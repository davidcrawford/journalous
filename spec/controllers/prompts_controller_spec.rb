require 'spec_helper'

describe PromptsController do
  integrate_views
  
  before(:each) do
    @user = Factory(:user)
  end
  
  describe "GET 'index'" do
  
    describe "success" do
      
      before(:each) do
        test_sign_in @user
      end
      
      it "should be successful" do
        get :index
        response.should be_success
      end
      
      it "should index prompts" do
        get :index
        response.should have_tag "ul#prompts" 
      end
      
    end
    
    describe "authentication failure" do
      
      it "should redirect you to signin" do
        get :index
        response.should redirect_to(signin_path)
      end
    end
  end
end
