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

ActiveRecord::Schema.define(version: 2020_12_31_081624) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clock_work_events", force: :cascade do |t|
    t.bigint "period_id"
    t.time "send_time"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["period_id"], name: "index_clock_work_events_on_period_id"
    t.index ["user_id"], name: "index_clock_work_events_on_user_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "foods", force: :cascade do |t|
    t.string "element", null: false
    t.decimal "protain_rate", precision: 6, scale: 5, null: false
    t.decimal "fat_rate", precision: 6, scale: 5, null: false
    t.decimal "carbohydrate_rate", precision: 6, scale: 5, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["element"], name: "index_foods_on_element"
  end

  create_table "logs", force: :cascade do |t|
    t.date "date", null: false
    t.decimal "weight", precision: 4, scale: 1
    t.decimal "bfp", precision: 3, scale: 1
    t.decimal "total_cal", precision: 5, scale: 1
    t.text "description"
    t.string "menu_numbers", array: true
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date", "description"], name: "index_logs_on_date_and_description"
    t.index ["user_id"], name: "index_logs_on_user_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "material", null: false
    t.string "names", null: false, array: true
    t.string "masses", null: false, array: true
    t.decimal "total_protain", precision: 5, scale: 1
    t.decimal "total_fat", precision: 5, scale: 1
    t.decimal "total_carbohydrate", precision: 5, scale: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material"], name: "index_menus_on_material"
  end

  create_table "users", force: :cascade do |t|
    t.string "nickname", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "jti", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.decimal "height", precision: 4, scale: 1
    t.integer "ideal_protain_rate"
    t.integer "ideal_fat_rate"
    t.integer "ideal_carbohydrate_rate"
    t.integer "target_cal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "clock_work_events", "users"
  add_foreign_key "logs", "users"
end
