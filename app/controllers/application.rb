# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  before_filter :authenticate
  before_filter :logout

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '9b5bef6d56fa4a02c76c37bc2414dde9'

  def authenticate
    if authenticate_or_request_with_http_basic {|username, password| username == 'zhook' && password == 'bug'}
      cookies[:zhookin] = { :value => "true", :expires => 1.hour.from_now }
    end
  end
  
  def logout
    if params[:logout]
      cookies.delete :zhookin
      redirect_to organizations_path
    end
  end

  def generate_filename_from_conditions(conditions, extension)
    parts = [params[:controller]]
    conditions.each_pair {|key, value| parts << "#{key}-#{value}" }
    parts.flatten.join("_").downcase + ".#{extension}"
  end

  def convert_hash_to_like_conditions hash
    conditions = [hash.keys.map{|k| "#{k} LIKE ?" }.join(" AND ")]
    conditions << hash.values.map{|v| "%#{v}%" }
    conditions.flatten
    
    # Examples..
    # [""]
    # ["state LIKE ?", "%nm%"]
    # ["state LIKE ? AND zip LIKE ?", "%nm%", "%87105%"]  
  end
  
  def get_job_count
    @job_count = DelayedJob.count
  end
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password
end
