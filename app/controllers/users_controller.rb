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
    username = params[:user][:username]
    user = User.find_by(username: username)
    if user # a user is found
      session[:user_id] = user.id
      flash[:success] = "Succesfully logged in as returning user #{username}"
      redirect_to works_path
      return
    else
      user = User.create(username: username, date_joined: Date.today)
      session[:user_id] = user.id
      flash[:success] = "Succesfully logged in as new user #{username}"
    end
    redirect_to works_path
    return
  end

  def current
    @current_user = User.find_by(id: params[:id])
    unless @current_user
      flash[:error] = "You must be logged in to vote"
      redirect_to root_path
    end
  end

  def logout
    user = User.find_by(id: session[:user_id])
    session[:user_id] = nil
      flash[:success] = "You have succesfully logged out."
      redirect_to root_path
  end
end
