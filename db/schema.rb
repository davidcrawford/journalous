# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100913042924) do

  create_table "answers", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "prompt_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",     :default => "draft"
  end

  add_index "answers", ["prompt_id"], :name => "index_answers_on_prompt_id"
  add_index "answers", ["user_id"], :name => "index_answers_on_user_id"

  create_table "invites", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "giver_name"
    t.string   "token"
    t.integer  "user_id"
  end

  add_index "invites", ["token"], :name => "index_invites_on_token", :unique => true

  create_table "prompts", :force => true do |t|
    t.string   "text"
    t.string   "quote"
    t.string   "quote_author"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "remember_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
