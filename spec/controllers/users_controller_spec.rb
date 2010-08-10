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
end

