class SessionsController < ApplicationController

  def signin
    user = login(params[:username], params[:password])
    unless user.blank?
      render json: user.to_json and return
    else
      render json: {:flash => "Invalid username or password"}, status: 500 and return
    end
  end
  
  def signout
    logout
    render json: {:flash => "You are successfully logged out"}, status: 200 and return
  end
  
  def is_logged_in
    if current_user.blank?
      render json: {}, status: 401 and return
    else
      render json: {}, status: 200 and return
    end
  end

end
