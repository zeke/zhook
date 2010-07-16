require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SiteFactoidsController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "site_factoids", :action => "index").should == "/site_factoids"
    end
  
    it "should map #new" do
      route_for(:controller => "site_factoids", :action => "new").should == "/site_factoids/new"
    end
  
    it "should map #show" do
      route_for(:controller => "site_factoids", :action => "show", :id => 1).should == "/site_factoids/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "site_factoids", :action => "edit", :id => 1).should == "/site_factoids/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "site_factoids", :action => "update", :id => 1).should == "/site_factoids/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "site_factoids", :action => "destroy", :id => 1).should == "/site_factoids/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/site_factoids").should == {:controller => "site_factoids", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/site_factoids/new").should == {:controller => "site_factoids", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/site_factoids").should == {:controller => "site_factoids", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/site_factoids/1").should == {:controller => "site_factoids", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/site_factoids/1/edit").should == {:controller => "site_factoids", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/site_factoids/1").should == {:controller => "site_factoids", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/site_factoids/1").should == {:controller => "site_factoids", :action => "destroy", :id => "1"}
    end
  end
end
