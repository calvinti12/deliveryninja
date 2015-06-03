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

ActiveRecord::Schema.define(version: 20150603174903) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "referrals", force: true do |t|
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "consumer_id"
  end

  add_index "referrals", ["consumer_id"], name: "index_referrals_on_consumer_id", using: :btree
  add_index "referrals", ["user_id"], name: "index_referrals_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "phone",                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",      default: false, null: false
    t.boolean  "available",  default: false
  end

end
