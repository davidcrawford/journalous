class Answer < ActiveRecord::Base
  attr_accessible :content
  
  belongs_to :user
  belongs_to :prompt
  
  validates_presence_of :user_id, :prompt_id, :content
end
