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

ActiveRecord::Schema.define(version: 2021_01_13_004957) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "trips", force: :cascade do |t|
    t.string "origin_city"
    t.string "destination_city"
    t.string "origin_iata"
    t.string "destination_iata"
    t.float "latitude"
    t.float "longitude"
    t.integer "price"
    t.datetime "departure_datetime"
    t.datetime "arrival_datetime"
    t.datetime "r_departure_datetime"
    t.datetime "r_arrival_datetime"
    t.string "booking_link"
    t.integer "trip_duration"
    t.integer "flight_id"
    t.bigint "weather_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["weather_id"], name: "index_trips_on_weather_id"
  end

end
