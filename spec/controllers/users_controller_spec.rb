require 'spec_helper'

describe UsersController do
  integrate_views

  describe "GET 'new'" do

    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'new'
      response.should have_tag "title", /Sign up/
    end
  end

  describe "GET 'show'" do
    
    before(:each) do
      @user = Factory(:user)
      User.stub!(:find, @user.id).and_return @user
    end

    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end
  end
  
  describe "GET 'answers'" do
    
    before(:each) do
      @user = Factory(:user)
      User.stub!(:find, @user.id).and_return @user
    end
    
    it "should be successful" do
      get :answers, :id => @user
      response.should be_success
    end
  end

  describe "POST 'create'" do

    describe "failure" do

      before(:each) do
        @attr = { :email => "boogiedown" }
        @user = Factory.build(:user, @attr)
        User.stub!(:new).and_return(@user)
        @user.should_receive(:save).and_return(false)
      end

      it "should have the right title" do
        post :create, :user => @attr
        response.should have_tag "title", /sign up/i
      end

      it "should render the 'new' template" do
        post :create, :user => @attr
        response.should render_template('new')
      end
    end

    describe "success" do
      
      before(:each) do
        @attr = {:email => "someone@minetowin.com",
          :password => "awesomep4ss",
          :password_confirmation => "awesomep4ss"
        }
        @user = Factory.build(:user)
        User.stub!(:new).and_return(@user)
        @user.should_receive(:save).and_return(true)
      end

      it "should redirect to list view" do
        post :create, :user => @attr
        response.should redirect_to :controller => 'pages', :action => 'list'
      end
      
      it "should sign the user in" do
        post :create, :user => @attr
        controller.should be_signed_in
      end
    end
  end
end

