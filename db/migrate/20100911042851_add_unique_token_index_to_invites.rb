class AddUniqueTokenIndexToInvites < ActiveRecord::Migration
  def self.up
    add_index :invites, :token, :unique => true
  end

  def self.down
    remove_index :invites, :token
  end
end
