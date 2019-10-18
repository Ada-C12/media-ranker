class UsersController < ApplicationController

  def login_form
    @user = User.new
  end 

  def login
    username = params[:username]
    user = User.find_by(username: username)
    if user
      session[:id] = user.id
      # make sure these names are named the same.
      flash[:success] = "Successfully logged in as returning user #{username}"
    else
      user = User.create(username: username, joined: Time.now)
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as new user #{username}"
    end
    redirect_to root_path
  end
end
