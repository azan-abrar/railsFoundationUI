class Company < ActiveRecord::Base
	attr_accessible :name, :website, :logo, :email, :departments_attributes, :phone

	validates :name, :phone, :presence => true, :uniqueness => true
	validates :website, :presence => true, :format => { :with => /^((http|https):\/\/)*[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix }
	validates :email, :presence => true, :uniqueness => true, :length => {:minimum => 6, :maximum => 100}, :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
	validates :phone, :format => { :with => /(^(03|3)\d{9}$)|(^\d{8,16}$)/ }

	has_many :departments
	has_many :employees

	has_attached_file :logo, 
	:styles => { :medium => "350x100>", :thumb => "175x50>" }, 
	:path => "#{Rails.root}/public/uploads/company_logos/:id.:extension",
	:url => "/uploads/company_logos/:id.:extension",
	:default_url => "company-logo.png"

	extend FriendlyId
	friendly_id :name, use: :slugged

	accepts_nested_attributes_for :departments

end
