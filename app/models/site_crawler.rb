require 'mechanize'
require 'timeout'

class SiteCrawler
  
  attr_accessor :logger, :phones, :emails
  
  def initialize
    @log = Logger.new("log/site_crawler.log")
    @phones = []
    @emails = []
    @bad_file_types = %w(mp3 aac pdf doc docx exe zip rar jpg gif png)
    Hpricot.buffer_size = 262144 # to avoid "ran out of buffer space" hpricot error
  end
  
  def find_organization organization_id
    @organization = Organization.find(organization_id, :include => [:google_factoids, :site_factoids])
  end
  
  def crawl_organization organization_id
    log "\n\n*** Begin crawling organization #{organization_id} ***"
    
    find_organization(organization_id)
    
    log "Name: #{@organization.name}\tEIN: #{@organization.ein}"
    
    log "site already searched. exit." and return if @organization.has_had_site_searched?
    
    # Try to get the organization's website address..
    if @organization.has_not_been_googled?
      log "organization has not yet been googled. googling now.."
      @organization.find_on_google
      find_organization(organization_id) # just in case it won't refresh itself automatically
    end

    # Can't proceed without a site URL, but take note so we won't try again in vain..
    create_unfruitful_factoid "no website found for organization" and return if @organization.website.blank?

    agent = WWW::Mechanize.new { |a| a.log = Logger.new("log/mechanize.log") }
    agent.read_timeout = 5 

    begin
      home_page = agent.get(@organization.website)
    rescue
      create_unfruitful_factoid "home page not retrievable (URL: #{@organization.website})"
      return
    end
    
    # Scrape home page
    scrape_page_for_emails(Hpricot(home_page.parser.to_s)) rescue ""
    scrape_page_for_phones(Hpricot(home_page.parser.to_s)) rescue ""

    # Collect all links that are relative or common to the domain..
    while @local_link = home_page.links.pop
      next if @local_link.blank?
      next if @local_link.uri.host != agent.history.first.uri.host rescue next # skip non-local links
      next if agent.visited? @local_link.href # skip visited links
      next if @bad_file_types.include? @local_link.href.split("?").first.split(".").last.downcase # skip file links

      begin
        page = Hpricot(agent.get(@local_link.href).parser.to_s)
      rescue
        log "unable to retrieve page #{@local_link.href}. skipping."
        next
      end
      
      scrape_page_for_emails page
      scrape_page_for_phones page
    end

    # In case we went through all the links and no dice..
    create_unfruitful_factoid("site crawled but no factoids found") if @organization.site_factoids.empty?
    
    log "done"
    
  rescue Net::HTTPNotFound => e
    create_unfruitful_factoid ("Net::HTTPNotFound: #{e}")
  rescue URI::InvalidURIError => e
    create_unfruitful_factoid ("URI::InvalidURIError: #{e}")
  end
  
  def scrape_page_for_emails page
    email_links = (page/"a").select{|a| !a.attributes['href'].blank? && a.attributes['href'].strip.downcase.starts_with?("mailto")}
    email_links.each do |email_link|
      address = email_link.attributes['href'].downcase.gsub("mailto:", "")
      unless @emails.include? address
        log "\tfound a new email: #{email_link.innerHTML}"
        content = "#{email_link.innerHTML}: #{address}"
        @organization.site_factoids.create(:kind => "email", :content => content, :source_url => @local_link.href, :fruitful => true)
        @emails << address
      end
    end
  end
  
  def scrape_page_for_phones page
    phones = page.to_s.strip_tags.scan(/\(?[0-9]{3}\)?[-. ]?[0-9]{3}[-. ]?[0-9]{4}/).map{|p| p.sanitize_phone}
    phones.each do |phone|
      unless @phones.include? phone
        log "\tfound a new phone: #{phone}"
        @organization.site_factoids.create(:kind => "phone", :content => phone, :source_url => @local_link.href, :fruitful => true)
        @phones << phone
      end
    end
  end
  
  def create_unfruitful_factoid reason
    f = @organization.site_factoids.create!(:fruitful => false, :kind => "failure", :content => reason)
    log "created unfruitful factoid: #{reason}"
  end
  
  def log msg
    @log.debug msg
  end

end