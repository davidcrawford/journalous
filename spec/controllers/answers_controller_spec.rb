require 'spec_helper'

describe AnswersController do

  describe "DELETE" do

    describe "failure" do
      
      it "should not be successful" do
        delete 'delete', :id => 1
        response.should_not be_success
      end
    end
    
    describe "success" do
      
      before(:each) do
        @answer = Factory(:answer)
      end
      
      it "should be successful" do
        delete 'delete', :id => @answer.id
        response.should be_success
      end
      
      it "should delete the answer" do
        Answer.should_receive(:find).with(@answer.id.to_s).and_return(@answer)
        @answer.should_receive(:destroy)
        delete 'delete', :id => @answer.id
      end
    end
  end
end
