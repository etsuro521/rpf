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

ActiveRecord::Schema.define(version: 2022_04_13_224012) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "monthly_goals", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "team_id"
    t.datetime "month"
    t.text "plan"
    t.text "action"
    t.text "output"
    t.text "review"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_monthly_goals_on_team_id"
  end

  create_table "tasks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deadline"
    t.string "urgency_importance"
    t.string "status"
    t.text "notes"
    t.bigint "group_id"
    t.string "to"
    t.string "from"
    t.bigint "team_id"
    t.string "updater"
    t.index ["group_id"], name: "index_tasks_on_group_id"
    t.index ["team_id"], name: "index_tasks_on_team_id"
    t.index ["user_id", "created_at"], name: "index_tasks_on_user_id_and_created_at"
    t.index ["user_id", "group_id"], name: "index_tasks_on_user_id_and_group_id"
    t.index ["user_id", "team_id"], name: "index_tasks_on_user_id_and_team_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "teams", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "group_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_teams_on_group_id"
  end

  create_table "user_groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "group_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false, null: false
    t.index ["group_id"], name: "index_user_groups_on_group_id"
    t.index ["user_id", "group_id"], name: "index_user_groups_on_user_id_and_group_id", unique: true
    t.index ["user_id"], name: "index_user_groups_on_user_id"
  end

  create_table "user_teams", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "team_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_user_teams_on_team_id"
    t.index ["user_id", "team_id"], name: "index_user_teams_on_user_id_and_team_id", unique: true
    t.index ["user_id"], name: "index_user_teams_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "weekly_goals", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "team_id"
    t.datetime "month"
    t.string "week"
    t.string "whose"
    t.text "plan"
    t.text "action"
    t.text "output"
    t.text "review"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_weekly_goals_on_team_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "monthly_goals", "teams"
  add_foreign_key "tasks", "groups"
  add_foreign_key "tasks", "teams"
  add_foreign_key "tasks", "users"
  add_foreign_key "teams", "groups"
  add_foreign_key "user_groups", "groups"
  add_foreign_key "user_groups", "users"
  add_foreign_key "user_teams", "teams"
  add_foreign_key "user_teams", "users"
  add_foreign_key "weekly_goals", "teams"
end
