class UsersController < ApplicationController
  
  before_action :find_user, only: [:index, :show]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      flash[:message] = "Username can't be empty!"
      render new_user_path
    end
  end
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find_by(id:params[:id])
    @votes = Vote.where(user_id: @user.id)
    head :not_found if @user.nil?
    
  end
  
  def login_form
    @user = User.new
  end
  
  def login
    username = params[:user][:username]
    @user = User.find_by(username: username)
    
    if @user 
      session[:user_id] = @user.id
      flash[:message] = "Successfully logged in as #{@user.username}"
      redirect_to current_user_path
    else
      @user = User.new(username: params[:user][:username])
      session[:user_id] = @user.id
      
      if @user.username == ""
        flash[:message] = "Username can't be empty!"
        redirect_to login_path  
        return
      end
      
      if @user = User.save
        flash[:message] = "successfully logged in as new user #{@user.username}"
      else 
        redirect_to root_path
      end
    end
  end
  
  def current
    # raise
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      flash[:error] = "You must be logged in to see this page"
      redirect_to root_path
    end
  end
  
  def logout
    
    session[:user_id] = nil
    flash[:message] = "You have logged out successfully."
    redirect_to root_path
  end
  
  private
  def user_params
    params.require(:user).permit(:username)
  end
  
  
  def find_user
    @current_user = User.find_by(id: session[:user_id])
  end
  
end
