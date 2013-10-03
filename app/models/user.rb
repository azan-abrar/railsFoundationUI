class User < ActiveRecord::Base
  authenticates_with_sorcery!

  simple_roles
  
  attr_accessible :username, :password, :password_confirmation, :employee_attributes

  validates :username, :password, :presence => true
  validates :username, :uniqueness => { :case_sensitive => false }
  validates :username, :format => { :with => /^[a-z0-9]+[\.\_\-]?[a-z0-9]+([\.\_\-]?[a-z0-9]+)*$/i }
  validates :username, :length => { :minimum => 3, :maximum => 50 }
  validates_length_of :password, :minimum => 5, :message => "must be at least 5 characters long", :if => :password
  validates_confirmation_of :password, :message => " and Confirm Password do not match", :if => :password

  has_one :employee
  accepts_nested_attributes_for :employee

  def is_active?
  	self.employee && self.employee.status == true
  end

  def name
    (self.employee.blank?) ? self.username : self.employee.full_name
  end

end
