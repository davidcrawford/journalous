class ChangeStringLengthOnInvites < ActiveRecord::Migration
  def self.up
    change_column :invites, :message, :text
  end

  def self.down
    change_column :invites, :message, :string
  end
end
