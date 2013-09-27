class Company < ActiveRecord::Base
	attr_accessible :name, :website, :logo

	validates :name, :slug, :presence => true, :uniqueness => true
	validates :website, :presence => true, :format => { :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix }

	has_many :departments

	has_attached_file :logo, 
	:styles => { :medium => "350x100>", :thumb => "175x50>" }, 
	:path => "#{Rails.root}/public/uploads/company_logos/:id.:extension",
	:url => "uploads/company_logos/:basename.:extension",
	:default_url => "confiz-logo.png"

	extend FriendlyId
	friendly_id :name, use: :slugged

end
