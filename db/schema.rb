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

ActiveRecord::Schema.define(:version => 20130926113334) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "website"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "slug"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "companies", ["slug"], :name => "index_companies_on_slug", :unique => true

  create_table "departments", :force => true do |t|
    t.string   "uuid"
    t.string   "name"
    t.string   "description"
    t.boolean  "is_deleted",  :default => false
    t.integer  "company_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "departments", ["uuid"], :name => "index_departments_on_uuid", :unique => true

  create_table "employees", :force => true do |t|
    t.string   "uuid"
    t.string   "employee_id"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "gender"
    t.string   "designation"
    t.integer  "department_id"
    t.integer  "company_id"
    t.boolean  "status",                 :default => false
    t.string   "resume_file_name"
    t.string   "resume_content_type"
    t.integer  "resume_file_size"
    t.datetime "resume_updated_at"
    t.date     "dob"
    t.boolean  "is_married",             :default => false
    t.datetime "join_date"
    t.string   "permanent_country_code"
    t.string   "permanent_address"
    t.string   "permanent_city"
    t.string   "permanent_state"
    t.string   "permanent_postal_code"
    t.string   "secondary_country_code"
    t.string   "secondary_address"
    t.string   "secondary_city"
    t.string   "secondary_state"
    t.string   "secondary_postal_code"
    t.string   "mobile_phone"
    t.string   "home_phone"
    t.boolean  "is_deleted",             :default => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "employees", ["designation"], :name => "index_employees_on_designation"
  add_index "employees", ["email"], :name => "index_employees_on_email"
  add_index "employees", ["first_name"], :name => "index_employees_on_first_name"
  add_index "employees", ["last_name"], :name => "index_employees_on_last_name"
  add_index "employees", ["middle_name"], :name => "index_employees_on_middle_name"
  add_index "employees", ["mobile_phone"], :name => "index_employees_on_mobile_phone"
  add_index "employees", ["uuid"], :name => "index_employees_on_uuid", :unique => true

  create_table "roles", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "roles", ["name"], :name => "index_roles_on_name", :unique => true

  create_table "user_roles", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "role_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_roles", ["user_id", "role_id"], :name => "index_user_roles_on_user_id_and_role_id"

  create_table "users", :force => true do |t|
    t.string   "username",         :null => false
    t.string   "crypted_password"
    t.string   "salt"
    t.integer  "employee_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
