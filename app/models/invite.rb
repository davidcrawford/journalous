class Invite < ActiveRecord::Base
  attr_accessible :name, :giver_name, :email, :message
  
  validates_presence_of :name, :giver_name, :email, :message
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_uniqueness_of :email
  
  before_save :generate_token
  
  private

    def generate_token
      if new_record?
        self.token = Digest::MD5.hexdigest(rand(999999).to_s + self.to_s)
      end
    end 
end
