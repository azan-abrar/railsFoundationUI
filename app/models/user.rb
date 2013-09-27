class User < ActiveRecord::Base
  authenticates_with_sorcery!

  simple_roles
  
  attr_accessible :username, :password, :employee_id
  
  belongs_to :employee

  def is_active?
  	self.employee && self.employee.status == true
  end

end
