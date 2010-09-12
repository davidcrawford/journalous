require 'spec_helper'

describe Invite do
  before(:each) do
    @attr = {
      :name => "Louis Armstrong",
      :giver_name => "David Crawford",
      :email => "larmstrong@memoirable.com",
      :message => "Old rockin' chair's got ya.  Cane by your side.  Please tell me your stories, father.\n\nLove,\nDave"
    }
  end

  it "should create a new instance given valid attributes" do
    Invite.create!(@attr)
  end
  
  it "should require a name" do
    no_name_invite = Invite.new(@attr.merge(:name => ""))
    no_name_invite.should_not be_valid
  end
  
  it "should require a giver name" do
    no_giver_invite = Invite.new(@attr.merge(:giver_name => ""))
    no_giver_invite.should_not be_valid
  end
  
  it "should require an email" do
    no_email_invite = Invite.new(@attr.merge(:email => ""))
    no_email_invite.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_invite = Invite.new(@attr.merge(:email => address))
      valid_email_invite.should be_valid
    end
  end
  
  it "should not accept invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_invite = Invite.new(@attr.merge(:email => address))
      invalid_email_invite.should_not be_valid
    end
  end
  
  describe "tokens" do
    
    before(:each) do
      @invite = Invite.create!(@attr)
    end
    
    it "should have a token" do
      @invite.should respond_to(:token)
    end
    
    it "should set the token" do
      @invite.token.should_not be_blank
    end
  end
end
