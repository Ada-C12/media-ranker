class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    user_id = params[:id].to_i
    @user = User.find_by(id: user_id)
    if @user.nil?
      head :not_found
      return
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      redirect_to user_path(@user.id)
    else
      render new_user_path
      return
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
      
    if @user.nil?
      head :not_found
      return
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.nil?
      head :not_found
      return
    elsif @user.update(user_params)
      redirect_to user_path(@user.id)
      return
    else
      render edit_user_path
      return
    end
  end

  def destroy
    user = User.find_by(id: params[:id])
    if user.nil?
      head :not_found
      return
    elsif user.destroy
      redirect_to users_path
      return
    else
      redirect_to :back
    end
    end




  private
  def user_params
    return params.require(:user).permit(:username)
  end

end
