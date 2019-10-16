class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)
    
    if user
      session[:user_id] = user.id
      session[:username] = username
      flash[:success] = "logged in as existing user #{ username }"
      redirect_to root_path
    else
      new_user = User.new(username: username)
      
      if new_user.save
        session[:user_id] = new_user.id
        session[:username] = username
        flash[:success] = "logged in as new user #{ username }"
        redirect_to root_path
      else
        flash[:action] = "log in"
        flash[:errors] = new_user.errors
        redirect_to login_path
      end
    end
  end

  def logout
    session[:username] = nil
    session[:user_id] = nil
    flash[:success] = "logged out"
    redirect_to root_path
  end

  def show
  end
end
