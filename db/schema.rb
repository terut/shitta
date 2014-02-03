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

ActiveRecord::Schema.define(version: 20130504085515) do

  create_table "comments", force: true do |t|
    t.integer  "note_id",    null: false
    t.integer  "user_id",    null: false
    t.text     "raw_body",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["note_id"], name: "index_comments_on_note_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "notes", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "title",      null: false
    t.string   "raw_body",   null: false
    t.string   "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["user_id"], name: "index_notes_on_user_id", using: :btree
  add_index "notes", ["uuid"], name: "index_notes_on_uuid", unique: true, using: :btree

  create_table "services", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "username",   null: false
    t.string   "token",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "services", ["user_id"], name: "index_services_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username",               null: false
    t.string   "password_digest",        null: false
    t.string   "name",                   null: false
    t.string   "email",                  null: false
    t.text     "bio"
    t.string   "reset_token"
    t.datetime "reset_token_expired_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
