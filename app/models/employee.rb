class Employee < ActiveRecord::Base
  attr_accessible :dob, :email, :first_name, :is_married, :job_id, :job_status, :join_date, :last_name, :middle_name, :permanent_address, :phone_1, :phone_2, :resume, :secondary_address
  
  has_one :user
  has_many :previous_jobs
  belongs_to :job
  
  validates :first_name, :last_name, :phone_1, :permanent_address, :email, :presence => true
  
  def full_name
    "#{self.first_name}#{" #{self.middle_name}"} #{self.last_name}"
  end
  
  def self.get_employees
    emps = Employee.all
    employees = []
    20.times do |t|
      emps.each do |emp|
        employees << emp.employee_hash
      end
    end
    return employees.flatten
  end
  
  def employee_hash
    {
      :full_name => self.full_name,
      :first_name => self.first_name,
      :middle_name => self.middle_name,
      :last_name => self.last_name,
      :email => self.email,
      :dob => self.dob,
      :is_married => (self.is_married ? "Yes" : "No"),
      :join_date => self.join_date.to_date,
      :permanent_address => self.permanent_address,
      :secondary_address => (self.secondary_address.blank? ? "N/A" : self.secondary_address),
      :phone_1 => self.phone_1,
      :phone_2 => (self.phone_2.blank? ? "N/A" : self.phone_2),
      :id => self.id,
      :resume => self.resume_path,
      :job => self.job.title,
      :job_status => self.job_status.blank? ? "Active" : "In-active"
    }
  end
  
  def resume_path 
    "www.confiz.com"
  end
  
end
