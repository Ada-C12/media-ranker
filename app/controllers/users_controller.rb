class UsersController < ApplicationController

  def index 
    @users = User.all
  end

  def show 
    @user = User.find_by(id: params[:id])
  end

  def current
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      head :not_found
      return
    end 
  end

  def login_form
    @user =  User.new
  end

  def login
    username = params[:user][:username]

    found_user = User.find_by(username: username)

    if found_user
      session[:user_id] = found_user.id
      flash[:message] = "Welcome back #{found_user.username}"
    else
      new_user = User.new(username: username)
      new_user.save
      session[:user_id] = new_user.id
      flash[:message] = "Welcome!"
    end
    return redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:message] = "You have logged out successfully."
    return redirect_to root_path
  end

end
