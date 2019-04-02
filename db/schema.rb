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

ActiveRecord::Schema.define(version: 2019_04_02_023141) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.bigint "user_id"
    t.float "price"
    t.date "uptime"
    t.integer "skill"
    t.string "district"
    t.string "city"
    t.string "address"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cover_image"
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "detail_courses", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_detail_courses_on_course_id"
    t.index ["user_id"], name: "index_detail_courses_on_user_id"
  end

  create_table "detail_events", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_detail_events_on_event_id"
    t.index ["user_id"], name: "index_detail_events_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id"
    t.string "address"
    t.string "district"
    t.string "city"
    t.date "uptime"
    t.float "price"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "topic_type"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_topics_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
  end

  add_foreign_key "courses", "users"
  add_foreign_key "detail_courses", "courses"
  add_foreign_key "detail_courses", "users"
  add_foreign_key "detail_events", "events"
  add_foreign_key "detail_events", "users"
  add_foreign_key "events", "users"
  add_foreign_key "topics", "users"
end
