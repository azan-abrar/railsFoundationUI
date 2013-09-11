class Employee < ActiveRecord::Base
  attr_accessible :dob, :email, :first_name, :is_married, :job_id, :job_status, :join_date, :last_name, :middle_name, :permanent_address, :phone_1, :phone_2, :resume, :secondary_address
  
  has_one :user
  has_many :previous_jobs
  belongs_to :job
  
  validates :first_name, :last_name, :phone_1, :permanent_address, :presence => true
  
  def full_name
    "#{self.first_name}#{" #{self.middle_name}"} #{self.last_name}"
  end
  
  def self.get_employees
    emps = Employee.all
    employees = []
    20.times do |t|
      emps.each do |emp|
        employees << {
          :full_name => emp.full_name,
          :email => emp.email,
          :dob => emp.dob,
          :is_married => (emp.is_married ? "Yes" : "No"),
          :join_date => emp.join_date.to_date,
          :permanent_address => emp.permanent_address,
          :phone_1 => emp.phone_1,
          :id => emp.id,
          :resume => emp.resume_path
        }
      end
    end
    return employees.flatten
  end
  
  def resume_path 
    "www.confiz.com"
  end
  
end
