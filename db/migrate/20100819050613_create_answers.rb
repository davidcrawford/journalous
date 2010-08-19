class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.string :content
      t.integer :user_id
      t.integer :prompt_id

      t.timestamps
    end
    add_index :answers, :user_id
    add_index :answers, :prompt_id
  end

  def self.down
    drop_table :answers
  end
end
