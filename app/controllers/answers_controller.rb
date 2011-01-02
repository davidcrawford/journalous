class AnswersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found
  
  def delete
    @answer = Answer.find(params[:id])
    @answer.destroy

    render  :json => { :response => "success" }.to_json
  end

  private
    def not_found
        render  :json => { :response => "failure", :error => "Could not find answer" },
                :status => 404
    end
end
