class RemoveQuestionMarksFromInviteRequests < ActiveRecord::Migration
  def self.up
    rename_column :invite_requests, :response_sent?, :response_sent
    rename_column :invite_requests, :invite_sent?, :invite_sent
  end

  def self.down
    rename_column :invite_requests, :response_sent, :response_sent?
    rename_column :invite_requests, :invite_sent, :invite_sent?
  end
end
