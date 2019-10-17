class UsersController < ApplicationController
  
  def index 
    @users = User.all
  end
  
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

  def user_params 
    user_params.require(:user).permit(:username)
  end
end
