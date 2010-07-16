require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/locales/index.html.erb" do
  include LocalesHelper
  
  before(:each) do
    assigns[:locales] = [
      stub_model(Locale,
        :zip => 1,
        :latitude => 1.5,
        :longitude => 1.5,
        :city => "value for city",
        :state => "value for state",
        :county => "value for county",
        :postal_type => "value for postal_type"
      ),
      stub_model(Locale,
        :zip => 1,
        :latitude => 1.5,
        :longitude => 1.5,
        :city => "value for city",
        :state => "value for state",
        :county => "value for county",
        :postal_type => "value for postal_type"
      )
    ]
  end

  it "should render list of locales" do
    render "/locales/index.html.erb"
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.5.to_s, 2)
    response.should have_tag("tr>td", 1.5.to_s, 2)
    response.should have_tag("tr>td", "value for city".to_s, 2)
    response.should have_tag("tr>td", "value for state".to_s, 2)
    response.should have_tag("tr>td", "value for county".to_s, 2)
    response.should have_tag("tr>td", "value for postal_type".to_s, 2)
  end
end

