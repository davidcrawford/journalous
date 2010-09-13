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
        @prompt = Factory(:prompt)
      end
      
      it "should be successful" do
        get :index
        response.should be_success
      end
      
      it "should show a prompt" do
        get :index
        response.should have_tag "#prompt" 
      end
    end
    
    describe "authentication failure" do
      
      it "should redirect you to signin" do
        get :index
        response.should redirect_to(signin_path)
      end
    end
  end
  
  describe "GET 'answered'" do
    
    before(:each) do
      test_sign_in @user
      @prompt = Factory(:prompt)
    end
    
    it "should be successful" do
      get :answered
      response.should be_success
    end
      
    it "should show answered prompts" do
      answer = Factory(:answer, :user => @user, :prompt => @prompt)
      Prompt.stub!(:all).and_return([@prompt])
      @user.stub!(:answer_for).with(@prompt).and_return(answer)
      get :answered
      response.should have_tag "ul#answered-prompts"
      response.should have_tag "#answer-" + answer.id.to_s
    end
  end 
  
  describe "POST 'answer'" do
    
    describe "failure" do
      
      it "should return 403 for json" do
        post :answer, :format => "json"
        response.should_not be_success
        response.status.should =~ /403/
      end
      
      it "should return 403 for xhr" do
        xhr :post, :answer
        response.should_not be_success
        response.status.should =~ /403/
      end
      
      it "should require a 'content' field" do
        test_sign_in @user
        post :answer, :format => "json"
        response.should_not be_success
        response.status.should =~ /400/
      end
      
      it "should require an id" do
        test_sign_in @user
        post :answer, :answer => { :content => "Yeah some content is here." }, :format => "json"
        response.should_not be_success
      end
    end
    
    describe "success" do
      
      before(:each) do
        Prompt.stub!(:find_by_id).with(1).and_return(Factory(:prompt))
        @answer_attr = { :content => "Meaningful story about my life." }
        test_sign_in @user
      end
      
      it "should be successful" do
        post :answer, :id => 1, :answer => @answer_attr, :format => "json"
        response.should be_success
      end
      
      it "should return an id" do
        post :answer, :id => 1, :answer => @answer_attr, :format => "json"
        response.body.should =~ /"id":[\s]*[0-9]/
      end
    end
  end
end
