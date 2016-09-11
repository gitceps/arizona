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

ActiveRecord::Schema.define(version: 20160911054910) do

  create_table "departments", force: :cascade do |t|
    t.integer  "university_id"
    t.string   "department_name"
    t.string   "college"
    t.string   "department_code"
    t.string   "isdaytime"
    t.string   "department_property"
    t.string   "department_status"
    t.string   "department_big_affiliation"
    t.string   "department_medium_affiliation"
    t.string   "department_small_affiliation"
    t.string   "course_term"
    t.string   "degree"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "distribution_majors", force: :cascade do |t|
    t.integer  "university_id"
    t.integer  "total_student_1"
    t.integer  "aplus_students_1"
    t.float    "aplus_ratio_1"
    t.integer  "azero_students_1"
    t.float    "azero_ratio_1"
    t.integer  "aminus_students_1"
    t.float    "aminus_ratio_1"
    t.integer  "bplus_students_1"
    t.float    "bplus_ratio_1"
    t.integer  "bzero_students_1"
    t.float    "bzero_ratio_1"
    t.integer  "bminus_students_1"
    t.float    "bminus_ratio_1"
    t.integer  "cplus_students_1"
    t.float    "cplus_ratio_1"
    t.integer  "czero_students_1"
    t.float    "czero_ratio_1"
    t.integer  "cminus_students_1"
    t.float    "cminus_ratio_1"
    t.integer  "dplus_students_1"
    t.float    "dplus_ratio_1"
    t.integer  "dzero_students_1"
    t.float    "dzero_ratio_1"
    t.integer  "dminus_students_1"
    t.float    "dminus_ratio_1"
    t.integer  "f_students_1"
    t.float    "f_ratio_1"
    t.integer  "total_student_2"
    t.integer  "aplus_students_2"
    t.float    "aplus_ratio_2"
    t.integer  "azero_students_2"
    t.float    "azero_ratio_2"
    t.integer  "aminus_students_2"
    t.float    "aminus_ratio_2"
    t.integer  "bplus_students_2"
    t.float    "bplus_ratio_2"
    t.integer  "bzero_students_2"
    t.float    "bzero_ratio_2"
    t.integer  "bminus_students_2"
    t.float    "bminus_ratio_2"
    t.integer  "cplus_students_2"
    t.float    "cplus_ratio_2"
    t.integer  "czero_students_2"
    t.float    "czero_ratio_2"
    t.integer  "cminus_students_2"
    t.float    "cminus_ratio_2"
    t.integer  "dplus_students_2"
    t.float    "dplus_ratio_2"
    t.integer  "dzero_students_2"
    t.float    "dzero_ratio_2"
    t.integer  "dminus_students_2"
    t.float    "dminus_ratio_2"
    t.integer  "f_students_2"
    t.float    "f_ratio_2"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "distribution_minors", force: :cascade do |t|
    t.integer  "university_id"
    t.integer  "total_student_1"
    t.integer  "aplus_students_1"
    t.float    "aplus_ratio_1"
    t.integer  "azero_students_1"
    t.float    "azero_ratio_1"
    t.integer  "aminus_students_1"
    t.float    "aminus_ratio_1"
    t.integer  "bplus_students_1"
    t.float    "bplus_ratio_1"
    t.integer  "bzero_students_1"
    t.float    "bzero_ratio_1"
    t.integer  "bminus_students_1"
    t.float    "bminus_ratio_1"
    t.integer  "cplus_students_1"
    t.float    "cplus_ratio_1"
    t.integer  "czero_students_1"
    t.float    "czero_ratio_1"
    t.integer  "cminus_students_1"
    t.float    "cminus_ratio_1"
    t.integer  "dplus_students_1"
    t.float    "dplus_ratio_1"
    t.integer  "dzero_students_1"
    t.float    "dzero_ratio_1"
    t.integer  "dminus_students_1"
    t.float    "dminus_ratio_1"
    t.integer  "f_students_1"
    t.float    "f_ratio_1"
    t.integer  "total_student_2"
    t.integer  "aplus_students_2"
    t.float    "aplus_ratio_2"
    t.integer  "azero_students_2"
    t.float    "azero_ratio_2"
    t.integer  "aminus_students_2"
    t.float    "aminus_ratio_2"
    t.integer  "bplus_students_2"
    t.float    "bplus_ratio_2"
    t.integer  "bzero_students_2"
    t.float    "bzero_ratio_2"
    t.integer  "bminus_students_2"
    t.float    "bminus_ratio_2"
    t.integer  "cplus_students_2"
    t.float    "cplus_ratio_2"
    t.integer  "czero_students_2"
    t.float    "czero_ratio_2"
    t.integer  "cminus_students_2"
    t.float    "cminus_ratio_2"
    t.integer  "dplus_students_2"
    t.float    "dplus_ratio_2"
    t.integer  "dzero_students_2"
    t.float    "dzero_ratio_2"
    t.integer  "dminus_students_2"
    t.float    "dminus_ratio_2"
    t.integer  "f_students_2"
    t.float    "f_ratio_2"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.string   "author"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "replies", force: :cascade do |t|
    t.text     "content"
    t.string   "author"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "universities", force: :cascade do |t|
    t.string   "year"
    t.string   "total_students"
    t.string   "name",           null: false
    t.string   "location"
    t.string   "is_4_5"
    t.string   "is_public"
    t.integer  "aplus_number"
    t.integer  "azero_number"
    t.integer  "aminus_number"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.integer  "university_id"
    t.integer  "department_id"
    t.float    "point"
    t.string   "uid"
    t.string   "name"
    t.string   "provider"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
