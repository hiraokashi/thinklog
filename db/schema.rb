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

ActiveRecord::Schema.define(version: 20150603144746) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adaptive_thoughts", force: :cascade do |t|
    t.text     "contents"
    t.integer  "automatic_thought_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "adaptive_thoughts", ["automatic_thought_id"], name: "index_adaptive_thoughts_on_automatic_thought_id", using: :btree

  create_table "adult_children_traits", force: :cascade do |t|
    t.text     "contents",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "automatic_thoughts", force: :cascade do |t|
    t.text     "contents"
    t.integer  "given_time_feeling_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "automatic_thoughts", ["given_time_feeling_id"], name: "index_automatic_thoughts_on_given_time_feeling_id", using: :btree

  create_table "bases", force: :cascade do |t|
    t.text     "contents"
    t.integer  "automatic_thought_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "bases", ["automatic_thought_id"], name: "index_bases_on_automatic_thought_id", using: :btree

  create_table "co_independent_traits", force: :cascade do |t|
    t.text     "contents",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cognitive_distortions", force: :cascade do |t|
    t.text     "question"
    t.text     "name",        null: false
    t.text     "discription"
    t.text     "example"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "distortion_examples", force: :cascade do |t|
    t.integer  "cognitive_diagnosis_id", null: false
    t.string   "example_contents",       null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "distortion_patterns", force: :cascade do |t|
    t.integer  "cognitive_distortion_id"
    t.integer  "automatic_thought_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "distortion_patterns", ["automatic_thought_id"], name: "index_distortion_patterns_on_automatic_thought_id", using: :btree
  add_index "distortion_patterns", ["cognitive_distortion_id"], name: "index_distortion_patterns_on_cognitive_distortion_id", using: :btree

  create_table "feelings", force: :cascade do |t|
    t.text     "contents",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "given_time_feelings", force: :cascade do |t|
    t.integer  "feeling_id"
    t.integer  "situation_id"
    t.integer  "before_percentage"
    t.integer  "after_percentage"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "given_time_feelings", ["feeling_id"], name: "index_given_time_feelings_on_feeling_id", using: :btree
  add_index "given_time_feelings", ["situation_id"], name: "index_given_time_feelings_on_situation_id", using: :btree

  create_table "rebuttals", force: :cascade do |t|
    t.text     "contents"
    t.integer  "automatic_thought_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "rebuttals", ["automatic_thought_id"], name: "index_rebuttals_on_automatic_thought_id", using: :btree

  create_table "situations", force: :cascade do |t|
    t.text     "when"
    t.text     "where"
    t.text     "with_whom"
    t.text     "what_have_you_been_doing"
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "situations", ["user_id"], name: "index_situations_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "adaptive_thoughts", "automatic_thoughts"
  add_foreign_key "automatic_thoughts", "given_time_feelings"
  add_foreign_key "bases", "automatic_thoughts"
  add_foreign_key "distortion_patterns", "automatic_thoughts"
  add_foreign_key "distortion_patterns", "cognitive_distortions"
  add_foreign_key "given_time_feelings", "feelings"
  add_foreign_key "given_time_feelings", "situations"
  add_foreign_key "rebuttals", "automatic_thoughts"
  add_foreign_key "situations", "users"
end
