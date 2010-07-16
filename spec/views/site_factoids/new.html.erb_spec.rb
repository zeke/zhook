require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/site_factoids/new.html.erb" do
  include SiteFactoidsHelper
  
  before(:each) do
    assigns[:site_factoid] = stub_model(SiteFactoid,
      :new_record? => true,
      :organization_id => 1,
      :kind => "value for kind",
      :content => "value for content",
      :source_url => "value for source_url",
      :fruitful => false
    )
  end

  it "should render new form" do
    render "/site_factoids/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", site_factoids_path) do
      with_tag("input#site_factoid_organization_id[name=?]", "site_factoid[organization_id]")
      with_tag("input#site_factoid_kind[name=?]", "site_factoid[kind]")
      with_tag("input#site_factoid_content[name=?]", "site_factoid[content]")
      with_tag("input#site_factoid_source_url[name=?]", "site_factoid[source_url]")
      with_tag("input#site_factoid_fruitful[name=?]", "site_factoid[fruitful]")
    end
  end
end


