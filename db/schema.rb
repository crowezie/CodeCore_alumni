# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150919175735) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assets", force: :cascade do |t|
    t.string   "linkedin"
    t.string   "github"
    t.string   "twitter"
    t.string   "resume"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "profile_id"
  end

  add_index "assets", ["profile_id"], name: "index_assets_on_profile_id", using: :btree

  create_table "educations", force: :cascade do |t|
    t.string   "school_name"
    t.integer  "year_from"
    t.integer  "year_to"
    t.string   "degree"
    t.string   "logo"
    t.integer  "profile_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "educations", ["profile_id"], name: "index_educations_on_profile_id", using: :btree

  create_table "experiences", force: :cascade do |t|
    t.string   "position"
    t.string   "company"
    t.text     "description"
    t.string   "weblink"
    t.string   "logo"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "profile_id"
  end

  add_index "experiences", ["profile_id"], name: "index_experiences_on_profile_id", using: :btree

  create_table "inquiries", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "profile_id"
  end

  add_index "inquiries", ["profile_id"], name: "index_inquiries_on_profile_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.text     "description"
    t.boolean  "availability"
    t.text     "pitch"
    t.string   "image"
    t.string   "phone"
    t.string   "email"
    t.string   "location"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "logo"
    t.string   "weblink"
    t.string   "sourcecode"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "profile_id"
  end

  add_index "projects", ["profile_id"], name: "index_projects_on_profile_id", using: :btree

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.integer  "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "profile_id"
  end

  add_index "skills", ["profile_id"], name: "index_skills_on_profile_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

  add_foreign_key "assets", "profiles"
  add_foreign_key "educations", "profiles"
  add_foreign_key "experiences", "profiles"
  add_foreign_key "inquiries", "profiles"
  add_foreign_key "profiles", "users"
  add_foreign_key "projects", "profiles"
  add_foreign_key "skills", "profiles"
end
