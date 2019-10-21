class UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      head :not_found
    end
  end
  
  def login_form
    if !session[:user_id]
      @user = User.new
    else
      redirect_to user_path(session[:user_id])
    end
  end
  
  def login
    username = params[:user][:username]
    @user = User.find_by(username: username)

    if !session[:user_id]
      if @user
        flash[:success] = "Successfully logged in as existing user #{@user.username}"    
      else
        @user = User.new(username: params[:user][:username])
        if @user.save
          flash[:success] = "Successfully created new user #{@user.username} with ID #{@user.id}"
        else
          flash[:error] = "A problem occurred: Could not log in"
          render :login_form
          return
        end
      end
      session[:user_id] = @user.id
    end
    
    redirect_to root_path
    return
  end
  
  def logout
    if session[:user_id]
      session[:user_id] = nil
      flash[:success] = "Successfully logged out"
      redirect_to root_path
      return
    end
  end
end
