class UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def show
    user_id = params[:id]
    
    @user = User.find_by(id: user_id)
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
    @user = User.find_by(username: username)
    if @user
      session[:user_id] = @user.id
      session[:username] = @user.username
      flash[:success] = "Successfully logged in as returning user #{username}"
    else
      @user = User.new(username: username)
      
      if @user.save
        session[:user_id] = @user.id
        session[:username] = @user.username
        flash[:success] = "Successfully logged in as new user #{username}"
      else
        flash[:success] = "There was error creating a new user"
        redirect_to login_path
      end
    end
    redirect_to root_path
  end
  
  def logout
    unless session[:user_id]
      flash[:error] = "No user is logged in"
    else
      session[:user_id] = nil
      session[:username] = nil
      flash[:success] = "Successfully logged out"
    end
    redirect_to root_path
  end
end
