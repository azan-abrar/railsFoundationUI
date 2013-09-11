class Job < ActiveRecord::Base
  attr_accessible :company_id, :title
  
  has_many :previous_jobs
  has_many :employees
  belongs_to :company
end
