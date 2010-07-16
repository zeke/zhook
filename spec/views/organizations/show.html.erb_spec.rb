require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/organizations/show.html.erb" do
  include OrganizationsHelper
  before(:each) do
    assigns[:organization] = @organization = stub_model(Organization,
      :primary_name => "value for primary_name",
      :care_of_name => "value for care_of_name",
      :street => "value for street",
      :city => "value for city",
      :state => "value for state",
      :zip => "value for zip",
      :activity_codes => "value for activity_codes",
      :ntee_code => "value for ntee_code",
      :ein => "value for ein"
    )
  end

  it "should render attributes in <p>" do
    render "/organizations/show.html.erb"
    response.should have_text(/value\ for\ primary_name/)
    response.should have_text(/value\ for\ care_of_name/)
    response.should have_text(/value\ for\ street/)
    response.should have_text(/value\ for\ city/)
    response.should have_text(/value\ for\ state/)
    response.should have_text(/value\ for\ zip/)
    response.should have_text(/value\ for\ activity_codes/)
    response.should have_text(/value\ for\ ntee_code/)
    response.should have_text(/value\ for\ ein/)
  end
end

