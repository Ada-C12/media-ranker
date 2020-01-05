class UsersController < ApplicationController
  before_action :current_user

  def index
    @users = User.all
  end
  
  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:failure]= "Cannot find user"
      redirect_to root_path
    end
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)
    # a change

    if user
      session[:user_id] = user.id
    else
      user = User.create(username: username)
      session[:user_id] = user.id
    end
    flash[:success] = "Successfully logged in as #{user.username}"
    redirect_to root_path
  end

  def current 
    if !@current_user
      flash[:failure] = "Could not find user: #{@current_user.username}"
      redirect_to users_path
      return
    else
      flash[:success] = "Logged in as #{@current_user.username}"
    end
  end

  def logout
    user_id = session[:user_id] 
    current_user = User.find_by(id: user_id)
    
    if current_user 
      session[:user_id] = nil
      flash[:success] = "Successfully logged out "
    else
      flash[:failure] = "Error logging out"
    end
    redirect_to root_path
  end
end
