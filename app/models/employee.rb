class Employee < ActiveRecord::Base
  attr_accessible :dob, :email, :first_name, :designation, :is_married, :job_status, 
    :join_date, :last_name, :middle_name, :permanent_address, :permanent_city, :permanent_postal_code, 
    :mobile_phone, :home_phone, :resume, :secondary_address, :secondary_city, :secondary_postal_code, 
    :uuid, :created_at, :updated_at, :department_id
  
  has_one :user
  belongs_to :department
  
  DESIGNATION_ARRAY = ["Accounts Manager", "Associate Product Manager", "Engagement Manager", "HR Executive", "HR Manager", "Product Manager", "Project Manager", "QA Engineer", "Senior Software Engineer", "Software Engineer"]
  JOB_STATUS_ARRAY = ["Associated to Confiz", "Left Confiz"]
  
  validates :first_name, :last_name, :permanent_address, :email, :permanent_city, :permanent_postal_code, :presence => true
  validates :mobile_phone, :format => {:with => /^03\d{9,10}$/}, :presence => true
  
  validates :home_phone, :format => {:with => /^03\d{9,10}$/}, :allow_blank => true
  validates :designation, :inclusion => { :in => DESIGNATION_ARRAY }, :presence => true
  validates :job_status, :inclusion => { :in => JOB_STATUS_ARRAY }, :presence => true
  
  validates :email, :uniqueness => true, :length => {:minimum => 6, :maximum => 100}, :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}

  after_create :generate_uuid
  
  default_scope where("is_deleted = false")
  
  def delete!
    self.is_deleted = true
    self.save
  end
  
  def full_name
    "#{self.first_name}#{" #{self.middle_name}"} #{self.last_name}"
  end
  
  def self.get_employees(params)
    query_string = params[:query].gsub("?query=", "") rescue ""
    page = (params[:page] || 1)
    emps = (!query_string.blank?) ? Employee.get_filtered_employees(query_string) : Employee.scoped
    emps = emps.includes(:department).paginate(:page => page, :per_page => PAGE_LIMIT)
    employees = []
    emps.each do |emp|
      employees << emp.employee_hash
    end
    return employees.flatten, emps
  end
  
  def employee_hash
    {
      :full_name => self.full_name,
      :first_name => self.first_name,
      :middle_name => (self.middle_name rescue ""),
      :last_name => self.last_name,
      :email => self.email,
      :dob => self.dob,
      :is_married => (self.is_married  rescue ""),
      :join_date => (self.join_date.to_date rescue ""),
      :permanent_address => self.permanent_address,
      :permanent_city => self.permanent_city,
      :permanent_postal_code => self.permanent_postal_code,
      
      :secondary_address => (self.secondary_address rescue ""),
      :secondary_city => (self.secondary_city rescue ""),
      :secondary_postal_code => (self.secondary_postal_code rescue ""),
      
      :mobile_phone => self.mobile_phone,
      :home_phone => (self.home_phone rescue ""),
      :id => self.uuid,
      :department_name => (self.department.name rescue ""),
      :department_id => (self.department.uuid rescue ""),
      :resume => self.resume_path,
      :designation => self.designation,
      :job_status => self.job_status
    }
  end
  
  def resume_path 
    "www.confiz.com"
  end
  
  def generate_uuid
    self.uuid = SecureRandom.hex(4)
    self.save
  end
  
  def self.get_filtered_employees(query_string)
    Employee.where("first_name like ? or middle_name like ? or last_name like ? or mobile_phone like ? or email like ? or designation like ?", "%#{query_string}%", "%#{query_string}%", "%#{query_string}%", "%#{query_string}%", "%#{query_string}%", "%#{query_string}%")
  end
  
end
