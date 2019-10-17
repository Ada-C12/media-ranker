class UsersController < ApplicationController
  def index
    @users = User.all
  end 

  def login_form
    @user = User.new
  end 

  def login
    username = params[:user][:username]

    found_user = User.find_by(username:username)
    if found_user
      session[:user_id] = found_user.id
      flash[:message] = "Logged in as returning user #{found_user.id}!"
    else
      new_user = User.create(username: username)
      session[:user_id] = new_user.id
      flash[:message] = "Created user #{new_user.id}"
    end
    return redirect_to root_path
  end

  def self.current
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      flash[:error] = "You must be logged in to do that"
      redirect_to root_path
    end 
  end 

  def logout
    session[:user_id] = nil
    flash[:message] = "You have logged out!"
    return redirect_to root_path 
  end
  
end
