require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/site_factoids/show.html.erb" do
  include SiteFactoidsHelper
  before(:each) do
    assigns[:site_factoid] = @site_factoid = stub_model(SiteFactoid,
      :organization_id => 1,
      :kind => "value for kind",
      :content => "value for content",
      :source_url => "value for source_url",
      :fruitful => false
    )
  end

  it "should render attributes in <p>" do
    render "/site_factoids/show.html.erb"
    response.should have_text(/1/)
    response.should have_text(/value\ for\ kind/)
    response.should have_text(/value\ for\ content/)
    response.should have_text(/value\ for\ source_url/)
    response.should have_text(/false/)
  end
end

