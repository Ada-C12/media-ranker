class UsersController < ApplicationController

  def index
    @users = User.order_by_joined
  end

  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)

    if @user.nil?
      redirect_to users_path
      flash[:failure] = "User #{user_id} does not exist."
      return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    name = params[:user][:name]
    user = User.find_by(name: name)

    if user 
      session[:user_id] = user.id
      flash[:success] = "Hello returning user #{name}."
    else
      user = User.create(name: name, joined_date: Date.today)
      session[:user_id] = user.id
      flash[:success] = "Hello new user #{name}."
    end
    redirect_to root_path
  end

  def current
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      flash[:error] = "You must be logged in to see this page"
      redirect_to root_path
    end
  end

  def logout
    session[:user_id] = nil
    flash[:logout] = "You are now logged out."
    redirect_to root_path
  end

  private

  def user_parmas
    return params.require(:user).permit(:name, :joined_date)
  end
end
