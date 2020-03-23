# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_23_173529) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "aeroplanes", force: :cascade do |t|
    t.string "model"
    t.bigint "number_of_seats"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "first_class_rows"
    t.integer "first_class_columns"
    t.bigint "first_class_base_fare"
    t.integer "business_rows"
    t.integer "business_columns"
    t.bigint "business_base_fare"
    t.integer "economy_rows"
    t.integer "economy_columns"
    t.bigint "economy_base_fare"
  end

  create_table "aeroplanes_passengers", id: false, force: :cascade do |t|
    t.bigint "passenger_id", null: false
    t.bigint "aeroplane_id", null: false
  end

  create_table "flights", force: :cascade do |t|
    t.date "date"
    t.time "departure"
    t.time "arrival"
    t.string "source"
    t.string "destination"
    t.bigint "aeroplane_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["aeroplane_id"], name: "index_flights_on_aeroplane_id"
  end

  create_table "passengers", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.string "gender"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.string "email"
    t.index ["user_id"], name: "index_passengers_on_user_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "seat_class"
    t.string "seat_number"
    t.bigint "total_amount"
    t.string "pnr"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "passenger_id", null: false
    t.bigint "flight_id", null: false
    t.bigint "user_id", null: false
    t.index ["flight_id"], name: "index_tickets_on_flight_id"
    t.index ["passenger_id"], name: "index_tickets_on_passenger_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "flights", "aeroplanes"
  add_foreign_key "passengers", "users"
  add_foreign_key "tickets", "flights"
  add_foreign_key "tickets", "passengers"
  add_foreign_key "tickets", "users"
end
