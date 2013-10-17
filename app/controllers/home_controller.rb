class HomeController < ApplicationController
  
  def index
  end

  def company_logo
  	company_logo = current_user ? current_user.company.logo.url : "/assets/logo.png"
  	render :json => {:company_logo => company_logo}, status: 200, layout: false and return
  end
  
end
