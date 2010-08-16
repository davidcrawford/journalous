require 'spec_helper'

describe "Users" do
  
  describe "signup" do
    
    describe "failure" do

      it "should not make a new user" do
        lambda do
          visit signup_path
          click_button
          response.should render_template('users/new')
          response.should have_tag("div#errorExplanation")
        end.should_not change(User, :count)
      end
    end

    describe "success" do
      
      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in :user_email, :with => "user@example.com"
          click_button
          response.should render_template("pages/list")
        end.should change(User, :count).by(1)
      end
      
      it "should send an email" do
        email = "user2@example.com"
        Email.should_receive(:send) do |to, options|
          to.should == "user2@example.com"
          options[:subject].should match(/welcome/i)
        end
        visit signup_path
        fill_in :user_email, :with => email
        click_button
      end
    end
  end
  
  describe "sign in/out" do
    
    describe "failure" do
      
      it "should not sign in" do
        
        visit signin_path
        fill_in :session_email, :with => ""
        fill_in :session_password, :with => ""
        click_button
        response.should render_template('sessions/new')
        response.should have_tag("div.flash.error", /wrong/i)
      end
    end
    
    describe "success" do
      
      it "should sign the user in" do
        user = Factory(:user)
        visit signin_path
        fill_in :session_email, :with => user.email
        fill_in :session_password, :with => user.password
        click_button
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
    end
  end
end
