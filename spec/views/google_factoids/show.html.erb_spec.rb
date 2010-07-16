require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/google_factoids/show.html.erb" do
  include GoogleFactoidsHelper
  before(:each) do
    assigns[:google_factoid] = @google_factoid = stub_model(GoogleFactoid,
      :ein => "value for ein",
      :website => "value for website",
      :phone => "value for phone",
      :address => "value for address",
      :source_url => "value for source_url"
    )
  end

  it "should render attributes in <p>" do
    render "/google_factoids/show.html.erb"
    response.should have_text(/value\ for\ ein/)
    response.should have_text(/value\ for\ website/)
    response.should have_text(/value\ for\ phone/)
    response.should have_text(/value\ for\ address/)
    response.should have_text(/value\ for\ source_url/)
  end
end

