class UsersController < ApplicationController
  
  before_action :find_user, only: [:show, :edit, :update]
  
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
  
  # this includes create for users that don't exist yet
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
        # render "users/login_form"
        render "users/login_form"
        return
      end
    end
    
    return redirect_to root_path
  end
  
  def logout
    if session[:user_id] == nil
      flash[:error] = "You are not logged in"
      redirect_to root_path
      return
    else
      session[:user_id] = nil
      flash[:success] = "Successfully logged out"
      redirect_to root_path
      return
    end
  end
  
  
end
