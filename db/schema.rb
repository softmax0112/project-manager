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

ActiveRecord::Schema.define(version: 2019_08_05_043053) do

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.string "affiliation"
    t.index ["name"], name: "index_clients_on_name"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "amount"
    t.integer "project_id"
    t.integer "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_payments_on_creator_id"
    t.index ["project_id"], name: "index_payments_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "hours_spent", default: 0
    t.integer "total_payment", default: 0
    t.integer "manager_id"
    t.integer "creator_id"
    t.integer "client_id"
    t.integer "payments_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_projects_on_client_id"
    t.index ["creator_id"], name: "index_projects_on_creator_id"
    t.index ["manager_id"], name: "index_projects_on_manager_id"
    t.index ["payments_id"], name: "index_projects_on_payments_id"
  end

  create_table "projects_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "project_id", null: false
    t.index ["project_id", "user_id"], name: "index_projects_users_on_project_id_and_user_id"
    t.index ["user_id", "project_id"], name: "index_projects_users_on_user_id_and_project_id"
  end

  create_table "time_logs", force: :cascade do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.integer "hours", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_time_logs_on_project_id"
    t.index ["user_id"], name: "index_time_logs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.boolean "enabled", default: true
    t.string "role", default: "user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
