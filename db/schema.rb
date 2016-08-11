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

ActiveRecord::Schema.define(version: 20160809041908) do

  create_table "posts", force: :cascade do |t|
    t.string   "point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "university", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.boolean  "is_4_5"
    t.boolean  "is_public"
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

end
