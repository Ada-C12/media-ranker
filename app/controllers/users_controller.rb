class UsersController < ApplicationController
  before_action :find_user, only: [:show, :current ] 
  
  def index
    @users = User.all
  end
  
  def show    
    if @user.nil?
      flash[:danger] = "User not found."
      redirect_to root_path
      return
    end
  end
  
  def login_form
    @user = User.new
  end
  
  def login
    username = params[:user][:username]
    user = User.find_by(username: username)
    
    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as existing user #{username}"
      redirect_to root_path
      return
    else
      user = User.create(username: username)
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as new user #{username}"
      return
    end
  end
  
  def current
    unless @user
      flash[:error] = "You must be logged in to see this page"
      redirect_to root_path
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out."
    redirect_to root_path
  end
  
  private
  
  def find_user
    @user = User.find_by(id: params[:id])
  end
end
