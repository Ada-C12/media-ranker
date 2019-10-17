class UsersController < ApplicationController
  
  before_action :find_user, except: [:login_form, :login]
  
  def index
    @users = User.all
  end
  
  def login_form
    @current_user = User.new
  end
  
  def login
    @current_user = User.find_by(username: params[:username])
    if @current_user
      session[:user_id] = @current_user.id
      flash[:success] = "Successfully logged in as returning user #{@current_user.username}"
    else
      @current_user = User.create(username: params[:username])
      session[:user_id] = @current_user.id
      flash[:success] = "Successfully logged in as new user #{@current_user.username}"
    end
    redirect_to root_path
  end
  
  def create
    @current_user = User.new(username: params[:username])
    if @current_user.save
      flash[:success] = "WORKS"
    else
      flash[:error] = "Could not log in"
    end
    redirect_to root_path    
  end
  
  def show; end
  
  def logout
    @current_user = User.find_by(id: session[:user_id])
    if @current_user
      session[:user_id] = nil
      flash[:success] = "You have been successfully logged out"
      redirect_to root_path
    else
      flash[:error] = "You have not even logged in"
      redirect_to root_path
    end
  end
  
  
  private
  
  # def user_params
  #   return params.require(:user).permit(:username)
  # end
  
  
  
end
