class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      head :not_found
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

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "user added successfully"
      redirect_to users_path
      return
    else
      flash.now[:failure] = "user failed to save"
      render :new
      return
    end
  end

  def update
    @user = User.find_by(id: params[:id])

    if @user.update(user_params)
      redirect_to user_path(@user)
      return
    else
      render :edit
      return
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])

    if @user.nil?
      flash[:error] = "Could you find user #{@user.name}"
      redirect_to users_path
      return
    end

    @user.destroy
    redirect_to users_path
    return
  end

  private

  def user_params
    return params.require(:user).permit(:name)
  end
end
