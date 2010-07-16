require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/google_factoids/new.html.erb" do
  include GoogleFactoidsHelper
  
  before(:each) do
    assigns[:google_factoid] = stub_model(GoogleFactoid,
      :new_record? => true,
      :ein => "value for ein",
      :website => "value for website",
      :phone => "value for phone",
      :address => "value for address",
      :source_url => "value for source_url"
    )
  end

  it "should render new form" do
    render "/google_factoids/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", google_factoids_path) do
      with_tag("input#google_factoid_ein[name=?]", "google_factoid[ein]")
      with_tag("input#google_factoid_website[name=?]", "google_factoid[website]")
      with_tag("input#google_factoid_phone[name=?]", "google_factoid[phone]")
      with_tag("input#google_factoid_address[name=?]", "google_factoid[address]")
      with_tag("input#google_factoid_source_url[name=?]", "google_factoid[source_url]")
    end
  end
end


