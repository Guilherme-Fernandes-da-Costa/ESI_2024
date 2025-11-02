# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_11_02_204902) do
  create_table "items", force: :cascade do |t|
    t.integer "list_id", null: false
    t.string "name"
    t.integer "quantity", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "added_by_id", null: false
    t.index ["added_by_id"], name: "index_items_on_added_by_id"
    t.index ["list_id"], name: "index_items_on_list_id"
  end

  create_table "list_shares", force: :cascade do |t|
    t.integer "list_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id", "user_id"], name: "index_list_shares_on_list_id_and_user_id", unique: true
    t.index ["list_id"], name: "index_list_shares_on_list_id"
    t.index ["user_id"], name: "index_list_shares_on_user_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "name"
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_lists_on_owner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "items", "lists"
  add_foreign_key "items", "users", column: "added_by_id"
  add_foreign_key "list_shares", "lists"
  add_foreign_key "list_shares", "users"
  add_foreign_key "lists", "users", column: "owner_id"
end
