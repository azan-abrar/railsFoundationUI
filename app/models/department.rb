class Department < ActiveRecord::Base
  attr_accessible :name, :description
  
  has_many :employees
end
