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

ActiveRecord::Schema.define(version: 2021_08_24_144853) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.float "start_latitude"
    t.float "start_longitude"
    t.string "token"
    t.integer "lives"
    t.boolean "finished"
    t.bigint "player_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_games_on_player_id"
  end

  create_table "items", force: :cascade do |t|
    t.boolean "eaten"
    t.boolean "super"
    t.float "longitude"
    t.float "latitude"
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_items_on_game_id"
  end

  create_table "participations", force: :cascade do |t|
    t.string "role", default: "{}"
    t.boolean "is_winner"
    t.string "state", default: "{}"
    t.bigint "game_id", null: false
    t.bigint "player_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_participations_on_game_id"
    t.index ["player_id"], name: "index_participations_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "nickname"
    t.float "longitude"
    t.float "latitude"
    t.string "color"
    t.string "food_types"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "games", "players"
  add_foreign_key "items", "games"
  add_foreign_key "participations", "games"
  add_foreign_key "participations", "players"
end
