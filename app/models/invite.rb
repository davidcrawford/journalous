class Invite < ActiveRecord::Base
  attr_accessible :name, :giver_name, :email, :message
  
  belongs_to :user
  
  validates_presence_of :name, :giver_name, :email, :message
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_uniqueness_of :email
  
  before_save :generate_token
  
  def accept password, password_confirmation
    user = User.new({
      :name => self.name,
      :email => self.email,
      :password => password,
      :password_confirmation => password_confirmation
    });
    
    if user.save
      self.user = user
      self.save
    end
    return user
  end
  
  private

    def generate_token
      if new_record?
        self.token = Digest::MD5.hexdigest(rand(999999).to_s + self.to_s)
      end
    end 
end
