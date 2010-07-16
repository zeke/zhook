require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/organizations/new.html.erb" do
  include OrganizationsHelper
  
  before(:each) do
    assigns[:organization] = stub_model(Organization,
      :new_record? => true,
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

  it "should render new form" do
    render "/organizations/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", organizations_path) do
      with_tag("input#organization_primary_name[name=?]", "organization[primary_name]")
      with_tag("input#organization_care_of_name[name=?]", "organization[care_of_name]")
      with_tag("input#organization_street[name=?]", "organization[street]")
      with_tag("input#organization_city[name=?]", "organization[city]")
      with_tag("input#organization_state[name=?]", "organization[state]")
      with_tag("input#organization_zip[name=?]", "organization[zip]")
      with_tag("input#organization_activity_codes[name=?]", "organization[activity_codes]")
      with_tag("input#organization_ntee_code[name=?]", "organization[ntee_code]")
      with_tag("input#organization_ein[name=?]", "organization[ein]")
    end
  end
end


