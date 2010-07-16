require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/site_factoids/index.html.erb" do
  include SiteFactoidsHelper
  
  before(:each) do
    assigns[:site_factoids] = [
      stub_model(SiteFactoid,
        :organization_id => 1,
        :kind => "value for kind",
        :content => "value for content",
        :source_url => "value for source_url",
        :fruitful => false
      ),
      stub_model(SiteFactoid,
        :organization_id => 1,
        :kind => "value for kind",
        :content => "value for content",
        :source_url => "value for source_url",
        :fruitful => false
      )
    ]
  end

  it "should render list of site_factoids" do
    render "/site_factoids/index.html.erb"
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for kind".to_s, 2)
    response.should have_tag("tr>td", "value for content".to_s, 2)
    response.should have_tag("tr>td", "value for source_url".to_s, 2)
    response.should have_tag("tr>td", false.to_s, 2)
  end
end

