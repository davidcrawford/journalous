require 'spec_helper'

describe Prompt do
  before(:each) do
    @attr = { :text => "Prompting you for a story." }
  end
  
  it "should create a new instance" do
    Prompt.create!(@attr)
  end
  
  it "should require text" do
    prompt = Prompt.new({})
    prompt.should_not be_valid
  end
   
end
