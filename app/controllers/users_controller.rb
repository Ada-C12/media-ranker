class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      head :not_found
      return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    found_user = User.find_by(username: username)

    if found_user
      session[:user_id] = found_user.id
      flash[:success] = "Successfully logged in as a existing user #{found_user.username}"
    else
      new_user = User.new(username: username)
      if new_user.save
        session[:user_id] = new_user.id
        flash[:success] = "Successfully created new user #{new_user.username} with ID #{new_user.id}"
      else
        flash[:error] = "A problem occured: Could not log in"
        redirect_to login_path
      end
    end
    redirect_to root_path
    return
  end

  def current
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      head :not_found
      return
    end
  end

  def logout
    if session[:user_id] == nil
      flash[:error] = "You are not logged in"
    else
      session[:user_id] = nil
      flash[:success] = "Successfully logged out"
    end
    return redirect_to root_path
  end
end
