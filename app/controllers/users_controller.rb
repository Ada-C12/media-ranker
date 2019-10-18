require 'date'

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def login_form
    @user = User.new
  end

  def login
    name = params[:user][:name]
    user = User.find_by(name: name)
    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as returning user #{name}"
    else
      user = User.create(name: name, joined: Date.today)
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as new user #{name}"
    end
  
    redirect_to root_path
  end

  def current
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      flash[:error] = "You must be logged in to vote"
      redirect_to root_path
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = 
    redirect_to root_path
  end
end
