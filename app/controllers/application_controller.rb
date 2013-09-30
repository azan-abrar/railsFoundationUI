require 'digest/md5'

class ApplicationController < ActionController::Base
	protect_from_forgery

	skip_before_filter  :verify_authenticity_token

	def has_admin_rights?
		redirect_to "/#/login" unless (current_user && current_user.admin?)
	end
end
