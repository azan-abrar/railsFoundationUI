# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@company = Company.find_or_create_by_name(
  :name => "Confiz Solutions",
  :website => "http://www.confiz.com"
)

@dept = Department.find_or_create_by_name(
  :name => "Engineering", :description => "This is Engineering Department"
)

@employee = Employee.find_or_create_by_first_name_and_last_name(
  :first_name => "Admin", :last_name => "Dummy",
  :email => "admin@example.com", :designation => Employee::DESIGNATION_ARRAY[0], 
  :department_id => @dept.id, :job_status => Employee::JOB_STATUS_ARRAY[0],
  :dob => (Time.now - 25.years).to_date, :join_date => (Time.now - 2.years), 
  :permanent_address => "Abc test-1", :permanent_city => "Lahore",
  :permanent_postal_code => "54000", :mobile_phone => "03451234567"
)

@user = User.find_or_create_by_username_and_email(
  :username => "admin", :email => "admin@example.com",
  :password => "admin", :employee_id => @employee.id
)