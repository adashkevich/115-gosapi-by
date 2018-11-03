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

ActiveRecord::Schema.define(version: 20181102190958) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "answers", force: :cascade do |t|
    t.string "text"
    t.string "organization"
    t.bigint "problem_id"
    t.index ["problem_id"], name: "index_answers_on_problem_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "icon"
    t.string "parent_id"
    t.string "title"
  end

  create_table "change_logs", force: :cascade do |t|
    t.string "old"
    t.string "new"
    t.string "field"
    t.date "change_date", default: -> { "CURRENT_TIMESTAMP" }
    t.bigint "problem_id"
    t.index ["problem_id"], name: "index_change_logs_on_problem_id"
  end

  create_table "photos", force: :cascade do |t|
    t.string "src"
    t.string "category"
    t.bigint "problem_id"
    t.index ["problem_id"], name: "index_photos_on_problem_id"
  end

  create_table "problems", force: :cascade do |t|
    t.string "href"
    t.string "address"
    t.geography "location", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.string "date_create"
    t.date "date_planned"
    t.date "crm_date_planned"
    t.date "crm_create_at"
    t.string "organisation_id"
    t.string "status"
    t.integer "rating"
    t.bigint "category_id"
    t.bigint "user_id"
    t.string "description"
    t.index ["category_id"], name: "index_problems_on_category_id"
    t.index ["user_id"], name: "index_problems_on_user_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "title"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.string "middle_name"
  end

  add_foreign_key "problems", "categories"
  add_foreign_key "problems", "users"
end
