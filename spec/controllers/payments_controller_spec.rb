require 'spec_helper'

describe PaymentsController do

  #Delete these examples and add some real ones
  it "should use PaymentsController" do
    controller.should be_an_instance_of(PaymentsController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'confirm'" do
    it "should be successful" do
      get 'confirm'
      response.should be_success
    end
  end

  describe "GET 'complete'" do
    it "should be successful" do
      get 'complete'
      response.should be_success
    end
  end
end
