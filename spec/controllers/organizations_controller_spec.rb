require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OrganizationsController do

  def mock_organization(stubs={})
    @mock_organization ||= mock_model(Organization, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all organizations as @organizations" do
      Organization.should_receive(:find).with(:all).and_return([mock_organization])
      get :index
      assigns[:organizations].should == [mock_organization]
    end

    describe "with mime type of xml" do
  
      it "should render all organizations as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Organization.should_receive(:find).with(:all).and_return(organizations = mock("Array of Organizations"))
        organizations.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested organization as @organization" do
      Organization.should_receive(:find).with("37").and_return(mock_organization)
      get :show, :id => "37"
      assigns[:organization].should equal(mock_organization)
    end
    
    describe "with mime type of xml" do

      it "should render the requested organization as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Organization.should_receive(:find).with("37").and_return(mock_organization)
        mock_organization.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  # describe "responding to GET new" do
  # 
  #   it "should expose a new organization as @organization" do
  #     Organization.should_receive(:new).and_return(mock_organization)
  #     get :new
  #     assigns[:organization].should equal(mock_organization)
  #   end
  # 
  # end
  # 
  # describe "responding to GET edit" do
  # 
  #   it "should expose the requested organization as @organization" do
  #     Organization.should_receive(:find).with("37").and_return(mock_organization)
  #     get :edit, :id => "37"
  #     assigns[:organization].should equal(mock_organization)
  #   end
  # 
  # end
  # 
  # describe "responding to POST create" do
  # 
  #   describe "with valid params" do
  #     
  #     it "should expose a newly created organization as @organization" do
  #       Organization.should_receive(:new).with({'these' => 'params'}).and_return(mock_organization(:save => true))
  #       post :create, :organization => {:these => 'params'}
  #       assigns(:organization).should equal(mock_organization)
  #     end
  # 
  #     it "should redirect to the created organization" do
  #       Organization.stub!(:new).and_return(mock_organization(:save => true))
  #       post :create, :organization => {}
  #       response.should redirect_to(organization_url(mock_organization))
  #     end
  #     
  #   end
  #   
  #   describe "with invalid params" do
  # 
  #     it "should expose a newly created but unsaved organization as @organization" do
  #       Organization.stub!(:new).with({'these' => 'params'}).and_return(mock_organization(:save => false))
  #       post :create, :organization => {:these => 'params'}
  #       assigns(:organization).should equal(mock_organization)
  #     end
  # 
  #     it "should re-render the 'new' template" do
  #       Organization.stub!(:new).and_return(mock_organization(:save => false))
  #       post :create, :organization => {}
  #       response.should render_template('new')
  #     end
  #     
  #   end
  #   
  # end
  # 
  # describe "responding to PUT udpate" do
  # 
  #   describe "with valid params" do
  # 
  #     it "should update the requested organization" do
  #       Organization.should_receive(:find).with("37").and_return(mock_organization)
  #       mock_organization.should_receive(:update_attributes).with({'these' => 'params'})
  #       put :update, :id => "37", :organization => {:these => 'params'}
  #     end
  # 
  #     it "should expose the requested organization as @organization" do
  #       Organization.stub!(:find).and_return(mock_organization(:update_attributes => true))
  #       put :update, :id => "1"
  #       assigns(:organization).should equal(mock_organization)
  #     end
  # 
  #     it "should redirect to the organization" do
  #       Organization.stub!(:find).and_return(mock_organization(:update_attributes => true))
  #       put :update, :id => "1"
  #       response.should redirect_to(organization_url(mock_organization))
  #     end
  # 
  #   end
  #   
  #   describe "with invalid params" do
  # 
  #     it "should update the requested organization" do
  #       Organization.should_receive(:find).with("37").and_return(mock_organization)
  #       mock_organization.should_receive(:update_attributes).with({'these' => 'params'})
  #       put :update, :id => "37", :organization => {:these => 'params'}
  #     end
  # 
  #     it "should expose the organization as @organization" do
  #       Organization.stub!(:find).and_return(mock_organization(:update_attributes => false))
  #       put :update, :id => "1"
  #       assigns(:organization).should equal(mock_organization)
  #     end
  # 
  #     it "should re-render the 'edit' template" do
  #       Organization.stub!(:find).and_return(mock_organization(:update_attributes => false))
  #       put :update, :id => "1"
  #       response.should render_template('edit')
  #     end
  # 
  #   end
  # 
  # end
  # 
  # describe "responding to DELETE destroy" do
  # 
  #   it "should destroy the requested organization" do
  #     Organization.should_receive(:find).with("37").and_return(mock_organization)
  #     mock_organization.should_receive(:destroy)
  #     delete :destroy, :id => "37"
  #   end
  # 
  #   it "should redirect to the organizations list" do
  #     Organization.stub!(:find).and_return(mock_organization(:destroy => true))
  #     delete :destroy, :id => "1"
  #     response.should redirect_to(organizations_url)
  #   end
  # 
  # end

end
