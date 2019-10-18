class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit] #, :update, :destroy]
  before_action :missing_user, only: [:show, :edit]
  
  def index
    @all_users = User.all_users
  end
  
  def show ; end
  
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
  
  # def edit ; end
  
  # def update
  #   if @user.nil?
  #     head :not_found
  #     return
  #   elsif @user.update(user_params)
  #     redirect_to user_path(@user.id)
  #     return
  #   else 
  #     render :edit
  #     return
  #   end
  # end
  
  # def destroy
  #   if @user.nil?
  #     head :not_found
  #     return
  #   elsif @user.destroy
  #     redirect_to users_path
  #     return
  #   else
  #     render :show
  #   end
  # end
  
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
