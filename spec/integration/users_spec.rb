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
end
