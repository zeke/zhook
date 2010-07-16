require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/locales/new.html.erb" do
  include LocalesHelper
  
  before(:each) do
    assigns[:locale] = stub_model(Locale,
      :new_record? => true,
      :zip => 1,
      :latitude => 1.5,
      :longitude => 1.5,
      :city => "value for city",
      :state => "value for state",
      :county => "value for county",
      :postal_type => "value for postal_type"
    )
  end

  it "should render new form" do
    render "/locales/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", locales_path) do
      with_tag("input#locale_zip[name=?]", "locale[zip]")
      with_tag("input#locale_latitude[name=?]", "locale[latitude]")
      with_tag("input#locale_longitude[name=?]", "locale[longitude]")
      with_tag("input#locale_city[name=?]", "locale[city]")
      with_tag("input#locale_state[name=?]", "locale[state]")
      with_tag("input#locale_county[name=?]", "locale[county]")
      with_tag("input#locale_postal_type[name=?]", "locale[postal_type]")
    end
  end
end


