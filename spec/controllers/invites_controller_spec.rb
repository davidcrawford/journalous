require 'spec_helper'

describe InvitesController do
  integrate_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_tag "title", /Send Invite/
    end
  end
  
  describe "GET 'show'" do
    
    before(:each) do
      @invite = Factory(:invite)
      Invite.stub!(:find, @invite.id).and_return @invite
    end
    
    it "should be successful" do
      get :show, :id => @invite
      response.should be_success
    end
    
    it "should show invite message" do
      get :show, :id => @invite
      response.should have_tag "#message", /#{@invite.message.split("\n")[0]}/
    end
  end
  
  describe "POST 'create'" do
    
    describe "failure" do
      
      before(:each) do
        @attr = { :email => "not.an@email" }
        @invite = Factory.build(:invite, @attr)
        Invite.stub!(:new).and_return(@invite)
        @invite.should_receive(:save).and_return(false)
      end
      
      it "should have the right title" do
        post :create, :invite => @invite
        response.should have_tag "title", /Send Invite/
      end
      
      it "should render the 'new' template" do
        post :create, :invite => @invite
        response.should render_template('new')
      end
    end
  end
  
  describe "POST 'accept'" do
    
    before(:each) do
      @invite = Factory(:invite)
      Invite.stub!(:find_by_token).and_return(@invite)
      @user = Factory(:user)
      @invite.should_receive(:accept).and_return(@user)
    end
    
    describe "failure" do
      
      it "should render the 'show' template" do
        @user.should_receive(:valid?).and_return(false)
        post :accept, :id => @invite.token, :user => @user
        response.should render_template('show')
      end
    end
    
    describe "success" do
      
      it "should redirect to the root path" do
        post :accept, :invite => @invite, :user => @user
        response.should redirect_to(root_path)
      end
    end
  end
end
