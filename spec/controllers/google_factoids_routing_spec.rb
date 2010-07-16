require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GoogleFactoidsController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "google_factoids", :action => "index").should == "/google_factoids"
    end
  
    it "should map #new" do
      route_for(:controller => "google_factoids", :action => "new").should == "/google_factoids/new"
    end
  
    it "should map #show" do
      route_for(:controller => "google_factoids", :action => "show", :id => 1).should == "/google_factoids/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "google_factoids", :action => "edit", :id => 1).should == "/google_factoids/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "google_factoids", :action => "update", :id => 1).should == "/google_factoids/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "google_factoids", :action => "destroy", :id => 1).should == "/google_factoids/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/google_factoids").should == {:controller => "google_factoids", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/google_factoids/new").should == {:controller => "google_factoids", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/google_factoids").should == {:controller => "google_factoids", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/google_factoids/1").should == {:controller => "google_factoids", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/google_factoids/1/edit").should == {:controller => "google_factoids", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/google_factoids/1").should == {:controller => "google_factoids", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/google_factoids/1").should == {:controller => "google_factoids", :action => "destroy", :id => "1"}
    end
  end
end
