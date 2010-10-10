require 'spec_helper'

describe InviteRequest do
  before(:each) do
    @valid_attributes = {
      :email => "email@indelible.me",
      :response_sent? => false,
      :invite_sent? => false
    }
  end

  it "should create a new instance given valid attributes" do
    InviteRequest.create!(@valid_attributes)
  end
end
