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

ActiveRecord::Schema.define(version: 20140831022216) do

  create_table "events", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.float    "lat"
    t.float    "lon"
    t.integer  "host_group_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["host_group_id"], name: "index_events_on_host_group_id"
  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "host_appointments", force: true do |t|
    t.integer  "user_id"
    t.integer  "host_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "host_appointments", ["host_group_id"], name: "index_host_appointments_on_host_group_id"
  add_index "host_appointments", ["user_id"], name: "index_host_appointments_on_user_id"

  create_table "host_groups", force: true do |t|
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "host_groups", ["event_id"], name: "index_host_groups_on_event_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
