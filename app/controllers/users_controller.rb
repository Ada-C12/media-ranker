class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      head :not_found
    end
  end

  def login_form
    @user = User.new
  end
  
  def login
    username = params[:user][:username]
    if username.nil? || username.strip == ""
      flash[:error] = "Username cannot be blank!"
      redirect_to login_path
      return
    end

    @user = User.find_by(username: params[:user][:username])
    if @user
      flash[:success] = "Logged in!"
      session[:user_id] = @user.id      
    else
      @user = User.create(username: params[:user][:username])
      flash[:success] = "User successfully created!"
      session[:user_id] = @user.id
    end
    redirect_to user_path(@user.id)
    return
  end

  def logout
    if session[:user_id]
        session[:user_id] = nil
        flash[:success] = "You have logged out"
        redirect_to works_path
        return
    end
  end
end
