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

ActiveRecord::Schema.define(version: 2020_05_02_121613) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "foods", force: :cascade do |t|
    t.string "food", null: false
    t.decimal "protain_rate", precision: 6, scale: 5, null: false
    t.decimal "fat_rate", precision: 6, scale: 5, null: false
    t.decimal "carbohydrate_rate", precision: 6, scale: 5, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "log_menus", force: :cascade do |t|
    t.bigint "log_id", null: false
    t.bigint "menu_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["log_id"], name: "index_log_menus_on_log_id"
    t.index ["menu_id"], name: "index_log_menus_on_menu_id"
  end

  create_table "logs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "log_name", null: false
    t.decimal "weight", precision: 4, scale: 1
    t.decimal "bfp", precision: 4, scale: 3
    t.integer "total_cal"
    t.bigint "user_id"
    t.bigint "management_id"
    t.bigint "menu_id"
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_logs_on_created_at"
    t.index ["management_id"], name: "index_logs_on_management_id"
    t.index ["menu_id"], name: "index_logs_on_menu_id"
    t.index ["user_id"], name: "index_logs_on_user_id"
  end

  create_table "managements", force: :cascade do |t|
    t.date "create_at", null: false
    t.decimal "body_mass_index", precision: 3, scale: 1
    t.decimal "body_fat_parcentage", precision: 4, scale: 3
    t.bigint "user_id"
    t.index ["user_id"], name: "index_managements_on_user_id"
  end

  create_table "menu_foods", force: :cascade do |t|
    t.bigint "menu_id"
    t.bigint "food_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_id"], name: "index_menu_foods_on_food_id"
    t.index ["menu_id"], name: "index_menu_foods_on_menu_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "menu", null: false
    t.integer "name", null: false
    t.integer "mass", null: false
    t.string "foods", null: false, array: true
    t.string "masses", null: false, array: true
    t.decimal "total_protain", precision: 5, scale: 1
    t.decimal "total_fat", precision: 5, scale: 1
    t.decimal "total_carbohydrate", precision: 5, scale: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "nickname", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.decimal "height", precision: 4, scale: 1
    t.decimal "weight", precision: 3, scale: 1
    t.integer "Protein_rate"
    t.integer "Fat_rate"
    t.integer "Carbohydrate_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "log_menus", "logs"
  add_foreign_key "log_menus", "menus"
  add_foreign_key "logs", "managements"
  add_foreign_key "logs", "menus"
  add_foreign_key "logs", "users"
  add_foreign_key "managements", "users"
  add_foreign_key "menu_foods", "foods"
  add_foreign_key "menu_foods", "menus"
end
