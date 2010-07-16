class OrganizationsController < ApplicationController

  def index

    # Conditions
    c = {}
    c[:primary_name] = params[:name] if params[:name]
    c[:zip] = params[:zip] if params[:zip]
    c[:city] = params[:city] if params[:city]
    c[:state] = params[:state] if params[:state]
    conditions = convert_hash_to_like_conditions c
    
    # Searching by county?
    if params[:county] && params[:state]
      locales = Locale.state(params[:state]).county(params[:county]).find(:all, :select => [:zip])
      zips = locales.map(&:zip).flatten
      first_part_of_conditions_array = conditions[0] 
      conditions[0] = "zip IN (#{zips.join(',')})" # Prepend county condition onto existing conditional array
      conditions[0] << " AND #{first_part_of_conditions_array}" unless first_part_of_conditions_array.blank?
    end
    
    # Options
    @options = {:conditions => conditions, :order => "primary_name ASC" }
    
    # Includes
    if metadata_desired?
      includes = [:google_factoids]
      includes << :site_factoids if search_site?
      @options.merge!({ :include => includes })
    end
    
    # Pagination (Disable limit for anything other than HTML)
    pagination_options = {:page => params[:page], :per_page => (params[:format] ? 10000000 : 50) }

    # Enqueue any necessary scraping jobs
    if scraping_is_necessary?
      @organizations.each do |org|
        next if search_site? && (org.has_had_site_searched? || org.has_been_googled_and_no_dice?)
        next if !search_site? && org.has_been_googled?
        job = search_site? ? SiteFactoidJob.new(org.id) : GoogleFactoidJob.new(org.id)
        Delayed::Job.enqueue job
      end
      @organizations = nil
      params[:format] = "html" # In case it was something else at first.
    else
      @organizations = Organization.paginate(:all, @options.merge(pagination_options))      
    end
    
    get_job_count
    
    # Output
    respond_to do |format|
      format.html
      format.xml  { render :xml => @organizations }
      format.csv do
        send_data(generate_csv, 
          :type => "text/csv; charset=iso-8859-1; header=present", 
          :disposition => "attachment; filename=#{generate_filename_from_conditions(c, 'csv')}")
      end
    end    
  end

  def count_jobs
    @delayed_job_count = DelayedJob.count
    render :text => "<b>#{@delayed_job_count}</b> jobs queued."
  end

  def show
    @organization = Organization.find_by_ein(params[:id], :include => [:google_factoids])
    @organization.find_on_google if params[:google]
    if params[:site]
      if org.has_had_site_searched? || org.has_been_googled_and_no_dice?
        flash[:warning] = "Sorry, the site has already been searched, or the organizations's website address is unknown."
      else
        flash[:notice] = "The zhook has been deployed for this organization. Refresh in a few minutes for results."
        Delayed::Job.enqueue SiteFactoidJob.new(@organization.id) unless org.has_had_site_searched? || org.has_been_googled_and_no_dice?  
      end    
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @organization }
    end
  end
  
  protected
  
  def metadata_desired?; search_google? || search_site?; end
  
  def search_google?; params[:metadata] == "google"; end
  
  def search_site?; %w(emails phones).include? params[:metadata]; end
  
  def scraping_is_necessary?
    return false unless metadata_desired?
    @organizations = Organization.find(:all, @options)
    return true if @organizations.any? {|org| org.has_not_been_googled? }
    return true if search_site? && @organizations.any? {|org| org.has_not_had_site_searched? }
    false
  end
    
  def generate_csv
    FasterCSV.generate do |csv|
      case params[:metadata]
      when "emails"
        csv << ["ein", "name", "email", "city", "state", "zip"]
        @organizations.each do |o| 
          o.site_factoids.each do |f|
            csv << [o.ein, o.name, f.email_only, o.city, o.state, o.zip] if f.email?
          end
        end
      when "phones"
        csv << ["ein", "name", "phone", "city", "state", "zip"]
        @organizations.each do |o| 
          o.site_factoids.each do |f|
            csv << [o.ein, o.name, f.content, o.city, o.state, o.zip] if f.phone?
          end
        end
      when "google"
        csv << ["ein", "name", "phone", "website", "google_street", "google_city", "google_state", "google_zip", "irs_street", "irs_city", "irs_state", "irs_zip"]
        @organizations.each do |o| 
          o.google_factoids.each do |f|
            csv << [o.ein, o.name, f.phone, f.website, f.street, f.city, f.state, f.zip, o.street.titlecase, o.city.titlecase, o.state, o.zip] if f.fruitful?
          end
        end
      else
        csv << ["ein", "name", "care_of_name", "street", "city", "state", "zip", "activity_codes", "ntee_code"]
        @organizations.each { |o| csv << [o.ein, o.name, o.care_of_name.titlecase, o.street.titlecase, o.city, o.state, o.zip, o.activity_codes, o.ntee_code] }
      end
    end
  end
    
end