class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit] #, :update, :destroy]
  before_action :missing_user, only: [:show, :edit]
  
  def index
    @all_users = User.all_users
  end
  
  def show ; end
  
  # def create
  #   @user = User.new(user_params)
  
  #   if @user.save
  #     redirect_to user_path(@user.id)
  #     return
  #   else 
  #     render :new 
  #     return
  #   end
  # end
  
  def login_form
    @user = User.new
  end
  
  def login
    name = params[:user][:name]
    user = User.find_by(name: name)
    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as returning user #{name}"
      redirect_to root_path
      return
    else
      user = User.new(name: name)
      if user.save
        session[:user_id] = user.id
        flash[:success] = "Successfully logged in as new user #{name}"
        redirect_to root_path
        return
      else
        flash[:failure] = "Name cannot be blank"
        redirect_to login_path
        return
      end
    end
  end
  
  def current
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      flash[:error] = "You must be logged in to do that"
      redirect_to root_path
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:success] = "You have been sucessfully logged out"
    redirect_to root_path
  end
  
  private
  
  def user_params
    return params.require(:user).permit(:name)
  end
  
  def find_user
    @user = User.find_by_id(params[:id])
  end
  
  def missing_user
    if @user.nil?
      head :not_found
      return
    end
  end
end
