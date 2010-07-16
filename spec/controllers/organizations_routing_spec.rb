require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OrganizationsController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "organizations", :action => "index").should == "/organizations"
    end
  
    it "should map #new" do
      route_for(:controller => "organizations", :action => "new").should == "/organizations/new"
    end
  
    it "should map #show" do
      route_for(:controller => "organizations", :action => "show", :id => 1).should == "/organizations/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "organizations", :action => "edit", :id => 1).should == "/organizations/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "organizations", :action => "update", :id => 1).should == "/organizations/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "organizations", :action => "destroy", :id => 1).should == "/organizations/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/organizations").should == {:controller => "organizations", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/organizations/new").should == {:controller => "organizations", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/organizations").should == {:controller => "organizations", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/organizations/1").should == {:controller => "organizations", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/organizations/1/edit").should == {:controller => "organizations", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/organizations/1").should == {:controller => "organizations", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/organizations/1").should == {:controller => "organizations", :action => "destroy", :id => "1"}
    end
  end
end
