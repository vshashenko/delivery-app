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

ActiveRecord::Schema[8.0].define(version: 2024_12_22_115301) do
  create_table "deliveries", force: :cascade do |t|
    t.string "pickup_address", null: false
    t.string "delivery_address", null: false
    t.float "weight", null: false
    t.float "distance", null: false
    t.datetime "scheduled_time", null: false
    t.decimal "cost", null: false
    t.string "driver_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
