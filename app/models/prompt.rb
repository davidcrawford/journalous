# == Schema Information
# Schema version: 20100729042959
#
# Table name: prompts
#
#  id           :integer         not null, primary key
#  text         :string(255)
#  quote        :string(255)
#  quote_author :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Prompt < ActiveRecord::Base
  attr_accessible :text, :quote, :quote_author
  
  has_many :answers
  
  validates_presence_of :text

  def hash
    self.id
  end
end
