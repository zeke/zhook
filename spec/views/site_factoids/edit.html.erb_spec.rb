require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/site_factoids/edit.html.erb" do
  include SiteFactoidsHelper
  
  before(:each) do
    assigns[:site_factoid] = @site_factoid = stub_model(SiteFactoid,
      :new_record? => false,
      :organization_id => 1,
      :kind => "value for kind",
      :content => "value for content",
      :source_url => "value for source_url",
      :fruitful => false
    )
  end

  it "should render edit form" do
    render "/site_factoids/edit.html.erb"
    
    response.should have_tag("form[action=#{site_factoid_path(@site_factoid)}][method=post]") do
      with_tag('input#site_factoid_organization_id[name=?]', "site_factoid[organization_id]")
      with_tag('input#site_factoid_kind[name=?]', "site_factoid[kind]")
      with_tag('input#site_factoid_content[name=?]', "site_factoid[content]")
      with_tag('input#site_factoid_source_url[name=?]', "site_factoid[source_url]")
      with_tag('input#site_factoid_fruitful[name=?]', "site_factoid[fruitful]")
    end
  end
end


