class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end
  
  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    found_user = User.find_by(username: username)

    if found_user
      session[:user_id] = found_user.id
      flash[:success] = "Successfully logged in as existing user #{found_user.username}"
    else
      @user = User.new(username: username)
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Successfully created new user #{@user.username} with ID #{@user.id}"
      else
        flash.now[:error] = "A problem occurred: Could not log in"
        render :login_form
        return 
      end
    end

    return redirect_to root_path
  end

  def logout
    if session[:user_id] == nil
      flash[:error] = "Action unavailable. No user logged in"
    else
      session[:user_id] = nil
      flash[:success] = "Successfully logged out"
    end
    return redirect_to root_path
  end
end
