class UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to root_path
    else
      render new_user_path
    end
  end
  
  def show
    @user = User.find_by(id:params[:id])
    
    head :not_found if @user.nil?
  end
  
  def login
  end
  
  def logout
  end
  
  private
  def user_params
    params.require(:user).permit(:username)
  end
  
end
