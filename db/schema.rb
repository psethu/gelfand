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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140416202951) do

  create_table "affiliations", force: true do |t|
    t.integer  "organization_id"
    t.integer  "program_id"
    t.text     "description"
    t.boolean  "followed_process"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bg_checks", force: true do |t|
    t.integer  "status"
    t.date     "criminal_date"
    t.date     "child_abuse_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "individual_id"
    t.date     "date_requested"
  end

  create_table "contacts", force: true do |t|
    t.string   "title"
    t.string   "phone"
    t.string   "email"
    t.string   "nickname"
    t.text     "notes"
    t.string   "street"
    t.string   "street2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "individuals", force: true do |t|
    t.string   "f_name"
    t.string   "l_name"
    t.boolean  "active"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role"
  end

  create_table "memberships", force: true do |t|
    t.integer  "individual_id"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "org_users", force: true do |t|
    t.integer  "organization_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.boolean  "is_partner"
    t.text     "description"
    t.boolean  "active"
    t.string   "department"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participants", force: true do |t|
    t.integer  "program_id"
    t.integer  "individual_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programs", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "start_date"
    t.date     "end_date"
    t.text     "cmu_facilities"
    t.text     "off_campus_facilities"
    t.integer  "num_minors"
    t.integer  "num_adults_supervising"
    t.integer  "irb_approval"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.boolean  "member",                 default: true
    t.integer  "individual_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
