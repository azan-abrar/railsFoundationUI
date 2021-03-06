# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@company = Company.find_or_create_by_name(
  :name => "Rails Foundation UI",
  :website => "http://www.example.com",
  :email => "dummy@example.com",
  :phone => "03211234567"
  )

@dept = Department.find_or_create_by_name(
  :name => "Engineering", :description => "This is Engineering Department", :company_id => @company.id
  )

@user = User.find_or_initialize_by_username(
  :username => "admin", :password => "admin"
  )
@user.roles = [:company_administrator, :admin]
@user.save!
puts "User #{@user.username} created."

100.times do |t|
  @employee = Employee.find_or_initialize_by_first_name_and_last_name(
    :employee_id => "CNE-#{(t+1)}", :first_name => "Admin#{(t+1)}", :last_name => "Dummy#{(t+1)}",
    :email => "admin#{(t+1)}@example.com", :designation => Employee::DESIGNATION_ARRAY[rand(Employee::DESIGNATION_ARRAY.count)], 
    :department_id => @dept.id, :dob => (Time.now - 25.years).to_date, :join_date => (Time.now - (rand(5)).years), 
    :permanent_address => "Abc test-1", :permanent_city => "Lahore",
    :permanent_postal_code => "54000", :mobile_phone => "03451234567",
    :gender => Employee::GENDER_ARRAY[rand(Employee::GENDER_ARRAY.count)],
    :permanent_country_code => "PK", :permanent_state => "Punjab"
    )
  @employee.company_id = @company.id
  @employee.user_id = @user.id if t == 0
  @employee.save!
  puts "Employee #{@employee.full_name} created."
end


