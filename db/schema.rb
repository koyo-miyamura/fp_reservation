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

ActiveRecord::Schema.define(version: 20180910085228) do

  create_table "fp_reservable_times", force: :cascade do |t|
    t.integer "fp_id", null: false
    t.datetime "reservable_on", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fp_id", "reservable_on"], name: "index_fp_reservable_times_on_fp_id_and_reservable_on"
    t.index ["fp_id"], name: "index_fp_reservable_times_on_fp_id"
  end

  create_table "fps", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_fps_on_email", unique: true
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "fp_id", null: false
    t.integer "user_id", null: false
    t.datetime "reserved_on", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fp_id", "reserved_on"], name: "index_reservations_on_fp_id_and_reserved_on"
    t.index ["fp_id"], name: "index_reservations_on_fp_id"
    t.index ["user_id", "reserved_on"], name: "index_reservations_on_user_id_and_reserved_on"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
