class SessionsController < ApplicationController

  def signin
    user = login(params[:username], params[:password], true)
    unless user.blank?
      render json: user.to_json and return
    else
      render json: {:flash => "Invalid username or password"}, status: 500 and return
    end
  end
  
  def signout
    debugger
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
