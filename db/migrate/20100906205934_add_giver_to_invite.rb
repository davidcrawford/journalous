class AddGiverToInvite < ActiveRecord::Migration
  def self.up
    add_column :invites, :giver_name, :string
  end

  def self.down
    remove_column :invites, :giver_name
  end
end
