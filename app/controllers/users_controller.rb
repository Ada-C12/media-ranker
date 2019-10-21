class UsersController < ApplicationController
  
  before_action :find_user, except: [:login_form, :login]
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def login_form
    @user = User.new
  end
  
  def login
    @user = User.find_by(username: user_params[:username])
    
    if @user
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in as returning user #{@user.username}"
      redirect_to root_path
    else
      @user = User.new(username: user_params[:username])
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Successfully logged in as new user #{@user.username}"
        redirect_to root_path
      else
        flash.now[:error] = "Could not log in"
        render :login_form
      end
    end
  end
  
  def current 
    @user = User.find(session[:user_id])
    unless @user
      flash[:error] = "You are not logged in"
      redirect_to root_path
    end
  end
  
  def create
    @user = User.new(username: user_params[:username])
    if @user.save
      flash[:success] = "WORKS"
    else
      flash[:error] = "Could not log in"
    end
    redirect_to root_path    
  end
  
  def logout
    @user = User.find_by(id: session[:user_id])
    if @user
      session[:user_id] = nil
      flash[:success] = "You have been successfully logged out"
      redirect_to root_path
    else
      flash[:error] = "You have not even logged in"
      redirect_to root_path
    end
  end
  
  
  private
  
  def user_params
    return params.require(:user).permit(:username)
  end
  
  
  
end
