class UsersController < ApplicationController
  def index
    @users = User.all
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
      redirect_to user_path(user.id)
      return
    else
      user = User.create(username: username)
      session[:user_id] = user.id
      flash[:success] = "Succesfully logged in as new user #{username}"
    end
    redirect_to user_path(user.id)
    return
  end

  def show
    @current_user = User.find_by(id: params[:id])
    unless @current_user
      flash[:error] = "You must be logged in to see this page"
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
