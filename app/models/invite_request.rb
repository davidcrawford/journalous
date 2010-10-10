class InviteRequest < ActiveRecord::Base
  attr_accessible :email, :invite_sent, :response_sent
end
