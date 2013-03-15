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

ActiveRecord::Schema.define(:version => 20130314085006) do

  create_table "admins", :force => true do |t|
    t.string   "email",              :default => "", :null => false
    t.string   "encrypted_password", :default => "", :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true

  create_table "events", :force => true do |t|
    t.string   "school_name"
    t.string   "start_place"
    t.string   "end_place"
    t.integer  "max_student"
    t.string   "allowance_claim"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.date     "event_date"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "agency_in_charge"
    t.integer  "backup_student"
    t.boolean  "hidden",           :default => false
  end

  create_table "profiles", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "contact_number"
    t.string   "national_identity"
    t.integer  "user_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "facebook_name"
    t.string   "current_university"
    t.string   "major_study"
    t.integer  "intake_year"
    t.integer  "graduation_year"
  end

  create_table "user_events", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_events", ["user_id", "event_id"], :name => "by_user_and_event", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "type"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
