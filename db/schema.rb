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

ActiveRecord::Schema.define(version: 20141108163701) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "scores", force: true do |t|
    t.integer  "stamina"
    t.integer  "strength"
    t.integer  "mind"
    t.integer  "vitality"
    t.integer  "agility"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scores", ["user_id"], name: "index_scores_on_user_id", using: :btree

  create_table "trackers", force: true do |t|
    t.integer  "tracker"
    t.string   "uuid"
    t.string   "omh_shim_id"
    t.integer  "user_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "authorized"
  end

  add_index "trackers", ["active"], name: "index_trackers_on_active", using: :btree
  add_index "trackers", ["authorized"], name: "index_trackers_on_authorized", using: :btree
  add_index "trackers", ["omh_shim_id"], name: "index_trackers_on_omh_shim_id", unique: true, using: :btree
  add_index "trackers", ["tracker"], name: "index_trackers_on_tracker", using: :btree
  add_index "trackers", ["user_id"], name: "index_trackers_on_user_id", using: :btree
  add_index "trackers", ["uuid"], name: "index_trackers_on_uuid", unique: true, using: :btree

  create_table "user_sessions", force: true do |t|
    t.integer  "user_id"
    t.string   "key"
    t.string   "ip"
    t.string   "user_agent"
    t.datetime "accessed_at"
    t.datetime "revoked_at"
  end

  add_index "user_sessions", ["accessed_at", "revoked_at"], name: "index_user_sessions_on_accessed_at_and_revoked_at", using: :btree
  add_index "user_sessions", ["accessed_at"], name: "index_user_sessions_on_accessed_at", using: :btree
  add_index "user_sessions", ["key"], name: "index_user_sessions_on_key", unique: true, using: :btree
  add_index "user_sessions", ["revoked_at"], name: "index_user_sessions_on_revoked_at", using: :btree
  add_index "user_sessions", ["user_id"], name: "index_user_sessions_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
