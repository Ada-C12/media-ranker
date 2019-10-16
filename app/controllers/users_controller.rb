class UsersController < ApplicationController

  def login_form
    @user = User.new
  end
  
  def login
    user = User.find_by(name: params[:user][:name])
    
    if user
      session[:user_id] = user.id
      flash[:success] = "You have sucessfully logged in #{user.name}"
    else
      user = User.create(name: params[:user][:name])
      session[:user_id] = user.id
      flash[:success] = "New user #{user.name} sucessfully created"
    end
    redirect_to root_path
  end
  
  def current
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      flash[:error] = "Please log in to see your information"
      redirect_to root_path
    end
  end
  
  def logout
    @user = User.find_by(id: session[:user_id])
    if @user
      session[:user_id] = nil
      flash[:success] = "You have sucessfully logged out"
      redirect_to root_path
    else
      flash[:error] = "You need to log in before you can log out"
    end
  end

end
