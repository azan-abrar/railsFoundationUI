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

@job = Job.find_or_create_by_title_and_company_id(
  :title => "Testing Job", :company_id => @company.id
)

@employee = Employee.find_or_create_by_first_name_and_last_name(
  :first_name => "Admin", :last_name => "Dummy",
  :email => "admin@example.com", :job_id => @job.id,
  :job_status => "Active", :dob => (Time.now - 25.years).to_date,
  :join_date => (Time.now - 2.years), :permanent_address => "Abc test-1",
  :phone_1 => "03451234567"
)

@user = User.find_or_create_by_username_and_email(
  :username => "admin", :email => "admin@example.com",
  :password => "admin", :employee_id => @employee.id
)