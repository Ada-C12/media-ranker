class UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)
    if @user.nil?
      head :not_found
      return
    end
  end
  
  def login_form
    @user = User.new
  end
  
  def login
    username = (params[:user][:username])
    user = User.find_by(username: username)
    
    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as returning user #{username}"
      redirect_to root_path
    else
      user = User.create(username: username)
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as new user #{username}"
      redirect_to root_path
    end
  end
  
  def current
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      flash[:error] = "You must be logged in to see this page!"
      redirect_to root_path
    end 
  end
  
  def logout
    session[:user_id] = nil
    redirect_to root_path
    
    flash[:completed] = "You have successfully logged out!"
  end
  
end
