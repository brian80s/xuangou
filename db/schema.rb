# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111219121827) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.text     "note"
    t.integer  "sequence"
    t.boolean  "visible"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cheers", :force => true do |t|
    t.integer  "user_id"
    t.string   "user_name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.string   "user_name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.string   "title"
    t.text     "content"
    t.boolean  "visible"
    t.boolean  "isdeleted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flags", :force => true do |t|
    t.integer  "user_id"
    t.string   "user_name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "accept_id"
    t.integer  "tp"
    t.text     "content"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "numberings", :force => true do |t|
    t.string "name"
    t.string "types"
    t.string "template", :default => ""
    t.text   "note"
  end

  create_table "operates", :force => true do |t|
    t.string  "number"
    t.string  "name"
    t.integer "parent_id"
    t.string  "controller"
    t.string  "action"
    t.string  "protocol",       :default => "GET"
    t.string  "note"
    t.integer "sequence",       :default => 0
    t.integer "level"
    t.integer "operates_count", :default => 0
    t.boolean "authable",       :default => true
    t.boolean "visible",        :default => true
  end

  add_index "operates", ["action"], :name => "index_operates_on_action"
  add_index "operates", ["controller"], :name => "index_operates_on_controller"

  create_table "operates_roles", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "operate_id"
  end

  create_table "operates_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "operate_id"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
    t.string "number"
    t.string "note"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.decimal  "price",           :precision => 10, :scale => 0
    t.string   "place"
    t.string   "latlng"
    t.integer  "photo_id"
    t.integer  "comments_count",                                 :default => 0
    t.integer  "flags_count",                                    :default => 0
    t.integer  "cheers_count",                                   :default => 0
    t.string   "cached_tag_list"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",               :default => "", :null => false
    t.string   "email",               :default => "", :null => false
    t.string   "crypted_password",    :default => "", :null => false
    t.string   "password_salt",       :default => "", :null => false
    t.string   "persistence_token",   :default => "", :null => false
    t.string   "single_access_token", :default => "", :null => false
    t.string   "perishable_token",    :default => "", :null => false
    t.integer  "name",                                :null => false
    t.integer  "login_count",         :default => 0,  :null => false
    t.integer  "failed_login_count",  :default => 0,  :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
