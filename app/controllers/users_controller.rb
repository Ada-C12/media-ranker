class UsersController < ApplicationController
  def index 
    @users = User.alphabetic
  end

  def show
    @user = User.find_by(id: params[:id])
    
    if @user.nil?
      redirect_to root_path
      return 
    end
  end

  def login_form
    @user =  User.new
  end

  def login
    name = params[:user][:name]
    user = User.find_by(name: name)
    if user
      session[:user_id] = user.id
    else
      user = User.create(name: name)
      session[:user_id] = user.id
    end
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end
end
