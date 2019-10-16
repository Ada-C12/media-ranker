class UsersController < ApplicationController
  
  def login
    username = params[:username]
    user = User.find_by(username: username)
    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as returning user #{username}"
    else
      user = User.create(username: username)
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as new user #{username}"
    end
    
    redirect_to root_path
  end 
  
  def login_form
    @user = user.new
  end 
  
  def current 
    @current_user = User.find_by(id: session[:user_id])
    Raise
    unless @current_user
      flash[:error] = "You must be logged in to see this page"
      redirect_to root_path
    end
  end
  
  def logout
  end
end
