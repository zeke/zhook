require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SiteFactoidsController do

  def mock_site_factoid(stubs={})
    @mock_site_factoid ||= mock_model(SiteFactoid, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all site_factoids as @site_factoids" do
      SiteFactoid.should_receive(:find).with(:all).and_return([mock_site_factoid])
      get :index
      assigns[:site_factoids].should == [mock_site_factoid]
    end

    describe "with mime type of xml" do
  
      it "should render all site_factoids as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        SiteFactoid.should_receive(:find).with(:all).and_return(site_factoids = mock("Array of SiteFactoids"))
        site_factoids.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested site_factoid as @site_factoid" do
      SiteFactoid.should_receive(:find).with("37").and_return(mock_site_factoid)
      get :show, :id => "37"
      assigns[:site_factoid].should equal(mock_site_factoid)
    end
    
    describe "with mime type of xml" do

      it "should render the requested site_factoid as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        SiteFactoid.should_receive(:find).with("37").and_return(mock_site_factoid)
        mock_site_factoid.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new site_factoid as @site_factoid" do
      SiteFactoid.should_receive(:new).and_return(mock_site_factoid)
      get :new
      assigns[:site_factoid].should equal(mock_site_factoid)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested site_factoid as @site_factoid" do
      SiteFactoid.should_receive(:find).with("37").and_return(mock_site_factoid)
      get :edit, :id => "37"
      assigns[:site_factoid].should equal(mock_site_factoid)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created site_factoid as @site_factoid" do
        SiteFactoid.should_receive(:new).with({'these' => 'params'}).and_return(mock_site_factoid(:save => true))
        post :create, :site_factoid => {:these => 'params'}
        assigns(:site_factoid).should equal(mock_site_factoid)
      end

      it "should redirect to the created site_factoid" do
        SiteFactoid.stub!(:new).and_return(mock_site_factoid(:save => true))
        post :create, :site_factoid => {}
        response.should redirect_to(site_factoid_url(mock_site_factoid))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved site_factoid as @site_factoid" do
        SiteFactoid.stub!(:new).with({'these' => 'params'}).and_return(mock_site_factoid(:save => false))
        post :create, :site_factoid => {:these => 'params'}
        assigns(:site_factoid).should equal(mock_site_factoid)
      end

      it "should re-render the 'new' template" do
        SiteFactoid.stub!(:new).and_return(mock_site_factoid(:save => false))
        post :create, :site_factoid => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested site_factoid" do
        SiteFactoid.should_receive(:find).with("37").and_return(mock_site_factoid)
        mock_site_factoid.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :site_factoid => {:these => 'params'}
      end

      it "should expose the requested site_factoid as @site_factoid" do
        SiteFactoid.stub!(:find).and_return(mock_site_factoid(:update_attributes => true))
        put :update, :id => "1"
        assigns(:site_factoid).should equal(mock_site_factoid)
      end

      it "should redirect to the site_factoid" do
        SiteFactoid.stub!(:find).and_return(mock_site_factoid(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(site_factoid_url(mock_site_factoid))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested site_factoid" do
        SiteFactoid.should_receive(:find).with("37").and_return(mock_site_factoid)
        mock_site_factoid.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :site_factoid => {:these => 'params'}
      end

      it "should expose the site_factoid as @site_factoid" do
        SiteFactoid.stub!(:find).and_return(mock_site_factoid(:update_attributes => false))
        put :update, :id => "1"
        assigns(:site_factoid).should equal(mock_site_factoid)
      end

      it "should re-render the 'edit' template" do
        SiteFactoid.stub!(:find).and_return(mock_site_factoid(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested site_factoid" do
      SiteFactoid.should_receive(:find).with("37").and_return(mock_site_factoid)
      mock_site_factoid.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the site_factoids list" do
      SiteFactoid.stub!(:find).and_return(mock_site_factoid(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(site_factoids_url)
    end

  end

end
