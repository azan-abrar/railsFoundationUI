class SessionsController < ApplicationController

  def signin
    if request.post?
      user = login(params[:username], params[:password], true)
      unless user.blank?
        redirect_to "/employees"
      end
    end
  end
  
  def signout
    logout
    render json: {:flash => "You are successfully logged out"}, status: 200 and return
  end
  
  def is_logged_in
    unless logged_in?
      render json: {}, status: 404 and return
    else
      render json: {}, status: 200 and return
    end
  end

end
