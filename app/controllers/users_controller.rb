class UsersController < ApplicationController

  def index 
    @users = User.alphabetic
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params) 
    if @user.save
      redirect_to user_path(@user.id) 
      return
    else 
      render :new 
      return
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to root_path
      return 
    end
  end

  private

  def user_params
    return params.require(:user).permit(:name)
  end

end
