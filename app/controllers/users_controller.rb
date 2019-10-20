class UsersController < ApplicationController
  
  def index 
    @users = User.all
  end
  
  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)
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
  
  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out."
    redirect_to root_path
  end
  
  def user_params 
    user_params.require(:user).permit(:username)
  end
end
