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

ActiveRecord::Schema.define(version: 20141231183224) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "subdomain"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "accounts", ["subdomain"], name: "index_accounts_on_subdomain", unique: true, using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.string   "gender",                 limit: 1
    t.string   "phone"
    t.string   "email"
    t.date     "date_of_birth"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "account_id"
    t.string   "encrypted_password",               default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zip"
    t.string   "address_country"
  end

  add_index "people", ["account_id"], name: "index_people_on_account_id", using: :btree
  add_index "people", ["email", "account_id"], name: "index_people_on_email_and_account_id", unique: true, using: :btree
  add_index "people", ["name"], name: "index_people_on_name", using: :btree
  add_index "people", ["reset_password_token"], name: "index_people_on_reset_password_token", unique: true, using: :btree

  create_table "people_roles", id: false, force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "role_id",   null: false
  end

  add_index "people_roles", ["person_id", "role_id"], name: "index_people_roles_on_person_id_and_role_id", unique: true, using: :btree

  create_table "roles", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "name"
    t.boolean  "login"
    t.string   "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "roles", ["account_id"], name: "index_roles_on_account_id", using: :btree

  add_foreign_key "people", "accounts"
  add_foreign_key "roles", "accounts"
end
