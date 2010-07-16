require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/google_factoids/index.html.erb" do
  include GoogleFactoidsHelper
  
  before(:each) do
    assigns[:google_factoids] = [
      stub_model(GoogleFactoid,
        :ein => "value for ein",
        :website => "value for website",
        :phone => "value for phone",
        :address => "value for address",
        :source_url => "value for source_url"
      ),
      stub_model(GoogleFactoid,
        :ein => "value for ein",
        :website => "value for website",
        :phone => "value for phone",
        :address => "value for address",
        :source_url => "value for source_url"
      )
    ]
  end

  it "should render list of google_factoids" do
    render "/google_factoids/index.html.erb"
    response.should have_tag("tr>td", "value for ein".to_s, 2)
    response.should have_tag("tr>td", "value for website".to_s, 2)
    response.should have_tag("tr>td", "value for phone".to_s, 2)
    response.should have_tag("tr>td", "value for address".to_s, 2)
    response.should have_tag("tr>td", "value for source_url".to_s, 2)
  end
end

