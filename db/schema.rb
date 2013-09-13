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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130909101616) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "website"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "departments", :force => true do |t|
    t.string   "uuid"
    t.string   "name"
    t.string   "description"
    t.boolean  "is_deleted",  :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "departments", ["uuid"], :name => "index_departments_on_uuid", :unique => true

  create_table "employees", :force => true do |t|
    t.string   "uuid"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "designation"
    t.integer  "department_id"
    t.string   "job_status"
    t.string   "resume"
    t.date     "dob"
    t.boolean  "is_married",            :default => false
    t.datetime "join_date"
    t.string   "permanent_address"
    t.string   "permanent_city"
    t.string   "permanent_postal_code"
    t.string   "secondary_address"
    t.string   "secondary_city"
    t.string   "secondary_postal_code"
    t.string   "mobile_phone"
    t.string   "home_phone"
    t.boolean  "is_deleted",            :default => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "employees", ["designation"], :name => "index_employees_on_designation"
  add_index "employees", ["email"], :name => "index_employees_on_email"
  add_index "employees", ["first_name"], :name => "index_employees_on_first_name"
  add_index "employees", ["last_name"], :name => "index_employees_on_last_name"
  add_index "employees", ["middle_name"], :name => "index_employees_on_middle_name"
  add_index "employees", ["mobile_phone"], :name => "index_employees_on_mobile_phone"
  add_index "employees", ["uuid"], :name => "index_employees_on_uuid", :unique => true

  create_table "users", :force => true do |t|
    t.string   "username",         :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.integer  "employee_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
