class UsersController < ApplicationController
  def login_form
    @user = User.new
  end
  
  def login
    username = params[:user][:username]
    @user = User.find_by(username: username)
    if @user
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in as returning user #{username}"
    else
      @user = User.new(username: username)
      @user.save

      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in as new user #{username}"
    end
    redirect_to root_path
  end
  
  def current
    @current_user = User.find_by(id: session[:user_id])
  end
  
  def logout
    unless session[:user_id]
      flash[:error] = "No user is logged in"
    else
      session[:user_id] = nil
      flash[:success] = "Successfully logged out"
    end
    redirect_to root_path
  end
end
