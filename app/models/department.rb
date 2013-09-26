class Department < ActiveRecord::Base
  attr_accessible :name, :description, :created_at, :is_deleted, :updated_at, :uuid, :company_id
  
  has_many :employees
  belongs_to :company
  
  validates :name, :description, :company_id, :presence => true
  
  after_create :generate_uuid
  
  default_scope where("is_deleted = false")
  
  def delete!
    self.is_deleted = true
    self.save
  end
  
  def self.get_departments(params)
    page = (params[:page] || 1)
    deps = Department.scoped
    deps = deps.paginate(:page => page, :per_page => PAGE_LIMIT)
    departments = []
    deps.each do |dep|
      departments << dep.department_hash
    end
    return departments.flatten, deps
  end
  
  def department_hash
    {
      :name => self.name,
      :description => self.description,
      :id => self.uuid,
    }
  end
  
  def generate_uuid
    self.uuid = SecureRandom.hex(4)
    self.save
  end
  
end
