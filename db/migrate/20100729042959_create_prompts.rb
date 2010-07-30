class CreatePrompts < ActiveRecord::Migration
  def self.up
    create_table :prompts do |t|
      t.string :text
      t.string :quote
      t.string :quote_author

      t.timestamps
    end
  end

  def self.down
    drop_table :prompts
  end
end
