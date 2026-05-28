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

ActiveRecord::Schema[8.1].define(version: 2026_05_28_174607) do
  create_table "task_levels", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "difficulty", default: 1, null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "task_types", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "icon_url"
    t.text "instructions"
    t.string "name"
    t.integer "task_level_id", null: false
    t.datetime "updated_at", null: false
    t.index ["task_level_id"], name: "index_task_types_on_task_level_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.text "board_state"
    t.datetime "created_at", null: false
    t.text "hint"
    t.boolean "horror_enabled", default: false, null: false
    t.integer "points", default: 10, null: false
    t.text "solution"
    t.integer "task_type_id", null: false
    t.integer "time_limit_sec", default: 45, null: false
    t.datetime "updated_at", null: false
    t.index ["task_type_id"], name: "index_tasks_on_task_type_id"
  end

  create_table "user_progresses", force: :cascade do |t|
    t.integer "attempts", default: 0, null: false
    t.datetime "created_at", null: false
    t.boolean "is_solved", default: false, null: false
    t.integer "task_id", null: false
    t.integer "time_spent_sec", default: 0, null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["task_id"], name: "index_user_progresses_on_task_id"
    t.index ["user_id"], name: "index_user_progresses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.boolean "horror_mode_enabled", default: false, null: false
    t.string "name", null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "task_types", "task_levels"
  add_foreign_key "tasks", "task_types"
  add_foreign_key "user_progresses", "tasks"
  add_foreign_key "user_progresses", "users"
end
