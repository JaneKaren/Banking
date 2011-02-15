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

ActiveRecord::Schema.define(:version => 106) do

  create_table "accounts", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "move_types", :force => true do |t|
    t.integer  "account_id"
    t.string   "name",                         :null => false
    t.boolean  "income",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "moves", :force => true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.integer  "move_type_id"
    t.decimal  "amount",       :precision => 10, :scale => 0, :default => 0
    t.date     "date"
    t.integer  "loan_id"
    t.string   "notice",                                      :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ownerships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
