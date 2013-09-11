class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  attr_accessible :username, :email, :password, :employee_id
  
  belongs_to :employee
end
