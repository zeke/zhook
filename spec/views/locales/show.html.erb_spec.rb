require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/locales/show.html.erb" do
  include LocalesHelper
  before(:each) do
    assigns[:locale] = @locale = stub_model(Locale,
      :zip => 1,
      :latitude => 1.5,
      :longitude => 1.5,
      :city => "value for city",
      :state => "value for state",
      :county => "value for county",
      :postal_type => "value for postal_type"
    )
  end

  it "should render attributes in <p>" do
    render "/locales/show.html.erb"
    response.should have_text(/1/)
    response.should have_text(/1\.5/)
    response.should have_text(/1\.5/)
    response.should have_text(/value\ for\ city/)
    response.should have_text(/value\ for\ state/)
    response.should have_text(/value\ for\ county/)
    response.should have_text(/value\ for\ postal_type/)
  end
end

