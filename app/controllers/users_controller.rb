class UsersController < ApplicationController

  def index
    @users = User.all
  end 

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      head :not_found
      return
    end 
  end 

  def login_form
    @user = User.new
  end 

  def login
    username = params[:username]

    user = User.find_by(username: username)
    if user != nil
      session[:id] = user.id
      # make sure the session keys are named the same.

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

    flash[:success] = "You are now logged out"
    redirect_to root_path 
  end 
end
