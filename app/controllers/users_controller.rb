class UsersController < ApplicationController

  def index
    @users = User.all
  end 

  def show
    @user = User.find_by(id: params[:id])
  end 

  def login_form
    @user = User.new
  end 

  def login
    username = params[:username]

    user = User.find_by(username: username)
    if user
      session[:id] = user.id
      # make sure these names are named the same.

      flash[:success] = "Successfully logged in as returning user #{username}"
    else
      user = User.create(username: username, joined: Time.now)
      session[:id] = user.id


      flash[:success] = "Successfully logged in as new user #{username}"
    end
    session[:username] = user.username
    redirect_to root_path
  end

  def logout
    session[:id] = nil

    # @current_user = User.find_by(id: session[:user_id])
    flash[:success] = "You are now logged out"
    redirect_to root_path 
  end 
end
