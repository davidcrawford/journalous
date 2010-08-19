class AddStatusToAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers, :status, :string, :default => "draft"
  end

  def self.down
    remove_column :answers, :status
  end
end
