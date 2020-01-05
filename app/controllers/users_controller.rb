class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)
    if username.strip == ""
      flash[:failure] = {general: "A problem occurred: Could not log in", username: "username: can't be blank"}
      redirect_to login_path
    else
      if user
        session[:user_id] = user.id
        flash[:success] = "Successfully logged in as existing user #{username}"
      else
        user = User.create(username: username)
        session[:user_id] = user.id
        flash[:success] = "Successfully created new user #{username} with #{user.id}"
      end
      redirect_to root_path
    end
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
    redirect_to root_path
  end

  def index
    @users = User.all
  end

  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)
    
    if @user.nil?
      redirect_to users_path
      return
    end
  end

  private
	def user_params
    return params.require(:user).permit(:username)
  end
end
