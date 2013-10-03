class Company < ActiveRecord::Base
	attr_accessible :name, :website, :logo, :email, :departments_attributes, :phone

	validates :email, :name, :phone, :presence => true, :uniqueness => true
	validates :website, :presence => true, :format => { :with => /^((http|https):\/\/)*[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix }
	validates :email, :uniqueness => true, :length => {:minimum => 6, :maximum => 100}, :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
	validates :phone, :format => { :with => /(^(03|3)\d{9}$)|(^\d{8,16}$)/ }

	has_many :departments
	has_many :employees

	has_attached_file :logo, 
	:styles => { :medium => "350x100>", :thumb => "175x50>" }, 
	:path => "#{Rails.root}/public/uploads/company_logos/:id.:extension",
	:url => "/uploads/company_logos/:id.:extension",
	:default_url => "confiz-logo.png"

	extend FriendlyId
	friendly_id :name, use: :slugged

	after_create :notify_signup

	accepts_nested_attributes_for :departments


	def notify_signup
		self.website = "https://#{self.website.split("//")[-1]}" if self.website !~ /^http:\/\/|^https:\/\//
		self.access_token = Digest::MD5.hexdigest("#{self.slug}#{SecureRandom.hex(2)}")
		self.save
		NotificationsMailer.company_signup_notification(self).deliver
	end

end
