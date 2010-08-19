require 'spec_helper'

describe Answer do
  before(:each) do
    @user = Factory(:user)
    @prompt = Factory(:prompt)
    @attr = {
      :content => "value for content"
    }
  end

  it "should have a status" do
    @answer = @user.answers.build(@attr)
    @answer.should respond_to(:status)
  end
  
  it "should default status to draft" do
    @answer = @user.answers.build(@attr)
    @answer.status.should == "draft"
  end
  
  describe "user associations" do
    
    before(:each) do
      @answer = @user.answers.build(@attr)
    end
    
    it "should have a user attribute" do
      @answer.should respond_to(:user)
    end
    
    it "should have the right associated user" do
      @answer.user_id.should == @user.id
      @answer.user.should == @user
    end
  end
  
  describe "user and prompt association" do
    
    before(:each) do
      @answer = @user.answer @prompt, "Blue"
    end
    
    it "should have the right associated user" do
      @answer.user_id.should == @user.id
    end

    it "should have the right associated prompt" do
      @answer.prompt_id.should == @prompt.id
      @answer.prompt.should == @prompt
    end
    
    it "should be findable" do
      Answer.find_by_id(@answer.id).should_not be_nil
    end
  end
  
  describe "validations" do
    
    it "should require a user id" do
      Answer.new(@attr).should_not be_valid
    end
  end
end
