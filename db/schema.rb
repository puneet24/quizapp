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

ActiveRecord::Schema.define(version: 20150711133159) do

  create_table "attempts", force: :cascade do |t|
    t.string   "option",     limit: 255
    t.integer  "user_id",    limit: 4
    t.integer  "quiz_id",    limit: 4
    t.integer  "problem_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "attempts", ["problem_id"], name: "index_attempts_on_problem_id", using: :btree
  add_index "attempts", ["quiz_id"], name: "index_attempts_on_quiz_id", using: :btree
  add_index "attempts", ["user_id"], name: "index_attempts_on_user_id", using: :btree

  create_table "problems", force: :cascade do |t|
    t.text     "prob_stat",  limit: 65535
    t.string   "option1",    limit: 255
    t.string   "option2",    limit: 255
    t.string   "option3",    limit: 255
    t.string   "option4",    limit: 255
    t.string   "prob_ans",   limit: 255
    t.integer  "quiz_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "problems", ["quiz_id"], name: "index_problems_on_quiz_id", using: :btree

  create_table "quiz_attendeds", force: :cascade do |t|
    t.integer  "score",      limit: 4
    t.integer  "user_id",    limit: 4
    t.integer  "quiz_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "quiz_attendeds", ["quiz_id"], name: "index_quiz_attendeds_on_quiz_id", using: :btree
  add_index "quiz_attendeds", ["user_id"], name: "index_quiz_attendeds_on_user_id", using: :btree

  create_table "quizzes", force: :cascade do |t|
    t.string   "quiz_name",  limit: 255
    t.string   "quiz_type",  limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "quizzes", ["user_id"], name: "index_quizzes_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "firstname",      limit: 255
    t.string   "lastname",       limit: 255
    t.string   "username",       limit: 255
    t.date     "date_ob"
    t.string   "password",       limit: 255
    t.string   "country",        limit: 255
    t.string   "email",          limit: 255
    t.integer  "quiz_attempted", limit: 4
    t.integer  "quiz_organised", limit: 4
    t.integer  "quiz_won",       limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_foreign_key "attempts", "problems"
  add_foreign_key "attempts", "quizzes"
  add_foreign_key "attempts", "users"
  add_foreign_key "problems", "quizzes"
  add_foreign_key "quiz_attendeds", "quizzes"
  add_foreign_key "quiz_attendeds", "users"
  add_foreign_key "quizzes", "users"
end
