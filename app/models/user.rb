# == Schema Information
# Schema version: 20100806055616
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'digest'

class User < ActiveRecord::Base
    attr_accessor :password
    attr_accessible :name, :email, :password, :password_confirmation
    
    validates_presence_of :email, :password
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
    validates_uniqueness_of :email
    validates_confirmation_of :password
    validates_length_of :password, :in => 6..40

    before_save :encrypt_password

    # Return true if the password matches the submitted password
    def has_password?(submitted)
      # Compare encrypted version of the password with encrypted submitted password
      encrypt(submitted) == encrypted_password
    end

    def self.authenticate(email, submitted_password)
      user = find_by_email(email)
      return nil if user.nil?
      return user if user.has_password?(submitted_password)
    end

    def remember_me!
      self.remember_token = encrypt("#{salt}--#{id}--#{Time.now.utc}")
      save_without_validation
    end
    
    private

      def encrypt_password
        unless password.nil?
          self.salt = make_salt if new_record?
          self.encrypted_password = encrypt(password)
        end
      end
      
      def encrypt(string)
        secure_hash("#{salt}--#{string}")
      end

      def make_salt
        secure_hash("#{Time.now.utc}--#{password}")
      end

      def secure_hash(string)
        Digest::SHA2.hexdigest(string)
      end
end
