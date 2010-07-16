require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GoogleFactoidsController do

  def mock_google_factoid(stubs={})
    @mock_google_factoid ||= mock_model(GoogleFactoid, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all google_factoids as @google_factoids" do
      GoogleFactoid.should_receive(:find).with(:all).and_return([mock_google_factoid])
      get :index
      assigns[:google_factoids].should == [mock_google_factoid]
    end

    describe "with mime type of xml" do
  
      it "should render all google_factoids as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        GoogleFactoid.should_receive(:find).with(:all).and_return(google_factoids = mock("Array of GoogleFactoids"))
        google_factoids.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested google_factoid as @google_factoid" do
      GoogleFactoid.should_receive(:find).with("37").and_return(mock_google_factoid)
      get :show, :id => "37"
      assigns[:google_factoid].should equal(mock_google_factoid)
    end
    
    describe "with mime type of xml" do

      it "should render the requested google_factoid as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        GoogleFactoid.should_receive(:find).with("37").and_return(mock_google_factoid)
        mock_google_factoid.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new google_factoid as @google_factoid" do
      GoogleFactoid.should_receive(:new).and_return(mock_google_factoid)
      get :new
      assigns[:google_factoid].should equal(mock_google_factoid)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested google_factoid as @google_factoid" do
      GoogleFactoid.should_receive(:find).with("37").and_return(mock_google_factoid)
      get :edit, :id => "37"
      assigns[:google_factoid].should equal(mock_google_factoid)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created google_factoid as @google_factoid" do
        GoogleFactoid.should_receive(:new).with({'these' => 'params'}).and_return(mock_google_factoid(:save => true))
        post :create, :google_factoid => {:these => 'params'}
        assigns(:google_factoid).should equal(mock_google_factoid)
      end

      it "should redirect to the created google_factoid" do
        GoogleFactoid.stub!(:new).and_return(mock_google_factoid(:save => true))
        post :create, :google_factoid => {}
        response.should redirect_to(google_factoid_url(mock_google_factoid))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved google_factoid as @google_factoid" do
        GoogleFactoid.stub!(:new).with({'these' => 'params'}).and_return(mock_google_factoid(:save => false))
        post :create, :google_factoid => {:these => 'params'}
        assigns(:google_factoid).should equal(mock_google_factoid)
      end

      it "should re-render the 'new' template" do
        GoogleFactoid.stub!(:new).and_return(mock_google_factoid(:save => false))
        post :create, :google_factoid => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested google_factoid" do
        GoogleFactoid.should_receive(:find).with("37").and_return(mock_google_factoid)
        mock_google_factoid.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :google_factoid => {:these => 'params'}
      end

      it "should expose the requested google_factoid as @google_factoid" do
        GoogleFactoid.stub!(:find).and_return(mock_google_factoid(:update_attributes => true))
        put :update, :id => "1"
        assigns(:google_factoid).should equal(mock_google_factoid)
      end

      it "should redirect to the google_factoid" do
        GoogleFactoid.stub!(:find).and_return(mock_google_factoid(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(google_factoid_url(mock_google_factoid))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested google_factoid" do
        GoogleFactoid.should_receive(:find).with("37").and_return(mock_google_factoid)
        mock_google_factoid.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :google_factoid => {:these => 'params'}
      end

      it "should expose the google_factoid as @google_factoid" do
        GoogleFactoid.stub!(:find).and_return(mock_google_factoid(:update_attributes => false))
        put :update, :id => "1"
        assigns(:google_factoid).should equal(mock_google_factoid)
      end

      it "should re-render the 'edit' template" do
        GoogleFactoid.stub!(:find).and_return(mock_google_factoid(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested google_factoid" do
      GoogleFactoid.should_receive(:find).with("37").and_return(mock_google_factoid)
      mock_google_factoid.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the google_factoids list" do
      GoogleFactoid.stub!(:find).and_return(mock_google_factoid(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(google_factoids_url)
    end

  end

end
