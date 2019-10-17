class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    user_username = params[:user][:username]
    user = User.find_by(username: user_username)
    if user.nil?
      # create new user
      user = User.create(username: user_username)
      render :login_form if user.errors.any?
      session[:user_id] = user.id
      flash[:success] = "Successfully created user #{user.username} and logged in!"
    else
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as #{user.username}!"
    end
    redirect_to root_path
  end

  def current
    @current_user = User.find_by(id: session[:user_id])
    if @current_user.nil?
      flash[:error] = "You have to be logged in to see that page"
      redirect_to root_path
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Logged out"
    redirect_to root_path
  end

end
