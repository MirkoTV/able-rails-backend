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

ActiveRecord::Schema.define(version: 2021_07_01_131720) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drivers", force: :cascade do |t|
    t.bigint "team_id"
    t.string "first_name"
    t.string "last_name"
    t.string "ui_name"
    t.integer "number"
    t.integer "all_time_best"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_drivers_on_team_id"
  end

  create_table "laps", force: :cascade do |t|
    t.bigint "performance_id"
    t.bigint "driver_id"
    t.integer "time"
    t.integer "s1_time"
    t.integer "s2_time"
    t.integer "s3_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["driver_id"], name: "index_laps_on_driver_id"
    t.index ["performance_id"], name: "index_laps_on_performance_id"
  end

  create_table "performances", force: :cascade do |t|
    t.bigint "driver_id"
    t.bigint "session_id"
    t.integer "best_lap_time"
    t.integer "best_s1_time"
    t.integer "best_s2_time"
    t.integer "best_s3_time"
    t.integer "best_potential_time"
    t.integer "average_time"
    t.boolean "dnf", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["driver_id"], name: "index_performances_on_driver_id"
    t.index ["session_id"], name: "index_performances_on_session_id"
  end

  create_table "sectors", force: :cascade do |t|
    t.bigint "lap_id"
    t.bigint "driver_id"
    t.integer "time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["driver_id"], name: "index_sectors_on_driver_id"
    t.index ["lap_id"], name: "index_sectors_on_lap_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "name"
    t.datetime "active_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
