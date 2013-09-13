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

100.times do |t|
  @employee = Employee.find_or_create_by_first_name_and_last_name(
    :first_name => "Admin#{(t+1)}", :last_name => "Dummy#{(t+1)}",
    :email => "admin#{(t+1)}@example.com", :designation => Employee::DESIGNATION_ARRAY[rand(Employee::DESIGNATION_ARRAY.count)], 
    :department_id => @dept.uuid, :job_status => Employee::JOB_STATUS_ARRAY[rand(Employee::JOB_STATUS_ARRAY.count)],
    :dob => (Time.now - 25.years).to_date, :join_date => (Time.now - (rand(5)).years), 
    :permanent_address => "Abc test-1", :permanent_city => "Lahore",
    :permanent_postal_code => "54000", :mobile_phone => "03451234567"
  )

  @user = User.find_or_create_by_username_and_email(
    :username => "admin#{(t+1)}", :email => "admin#{(t+1)}@example.com",
    :password => "admin#{(t+1)}", :employee_id => @employee.uuid
  )
  
  puts "User #{@user.username} created."
end
