require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/organizations/index.html.erb" do
  include OrganizationsHelper
  
  before(:each) do
    assigns[:organizations] = [
      stub_model(Organization,
        :primary_name => "value for primary_name",
        :care_of_name => "value for care_of_name",
        :street => "value for street",
        :city => "value for city",
        :state => "value for state",
        :zip => "value for zip",
        :activity_codes => "value for activity_codes",
        :ntee_code => "value for ntee_code",
        :ein => "value for ein"
      ),
      stub_model(Organization,
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
    ]
  end

  it "should render list of organizations" do
    render "/organizations/index.html.erb"
    response.should have_tag("tr>td", "value for primary_name".to_s, 2)
    response.should have_tag("tr>td", "value for care_of_name".to_s, 2)
    response.should have_tag("tr>td", "value for street".to_s, 2)
    response.should have_tag("tr>td", "value for city".to_s, 2)
    response.should have_tag("tr>td", "value for state".to_s, 2)
    response.should have_tag("tr>td", "value for zip".to_s, 2)
    response.should have_tag("tr>td", "value for activity_codes".to_s, 2)
    response.should have_tag("tr>td", "value for ntee_code".to_s, 2)
    response.should have_tag("tr>td", "value for ein".to_s, 2)
  end
end

