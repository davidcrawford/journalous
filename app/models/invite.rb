class Invite < ActiveRecord::Base
  attr_accessible :name, :giver_name, :email, :message
  
  validates_presence_of :name, :giver_name, :email, :message
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_uniqueness_of :email
end
