require 'hpricot'
require 'mechanize'
require 'timeout'

class GoogleCrawler
  
  attr_accessor :logger
  
  def initialize
    @log = Logger.new("log/google_crawler.log")
    Hpricot.buffer_size = 262144 # to avoid "ran out of buffer space" hpricot error
  end
  
  def find_organization organization_id
    @organization = Organization.find(organization_id)
    
    agent = WWW::Mechanize.new { |a| a.log = Logger.new("log/mechanize.log") }
    agent.read_timeout = 5
    
    log "\n\nName: #{@organization.name}\tEIN: #{@organization.ein}"
    
    search_string = "#{@organization.name}, #{@organization.city.titlecase} #{@organization.state}"
    source_url = "http://www.google.com/search?q=#{search_string}"
    log "source url: #{source_url}"
    doc = Hpricot(agent.get(source_url).parser.to_s) rescue ""
    
    return create_unfruitful_factoid("unable to open source url", source_url) if doc.blank?
    
    # TODO: Find a better way of doing this. This is very brittle..
    # google_local_match = (doc/"div.std") # This was working.. but no longer
    google_local_match = (doc/"div").select{|div| div.attributes['style'] == "width:18em;padding-top:0px" }.first
    
    return create_unfruitful_factoid("no google local match found", source_url) if google_local_match.blank?
    
    website = (google_local_match/"cite").innerHTML.strip_tags.gsub("maps.google.com", "")
    
    @organization.google_factoids.create!(
      :phone => google_local_match.innerHTML.strip_tags.match('\(?[0-9]{3}\)?[-. ]?[0-9]{3}[-. ]?[0-9]{4}').to_s.sanitize_phone,
      :address => google_local_match.innerHTML.gsub("<br />", "\n").strip_tags.gsub(website, "").split("(").first.gsub("maps.google.com", "").strip,
      :website => website.add_http,
      :fruitful => true
    )

  end
  
  def create_unfruitful_factoid reason, source_url
    f = @organization.google_factoids.create!(:fruitful => false, :notes => reason, :source_url => source_url)
    log "created unfruitful factoid: #{reason}"
  end
  
  def log msg
    @log.debug msg
  end

end