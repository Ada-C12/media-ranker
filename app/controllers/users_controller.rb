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
      flash[:success] = "Successfully logged in as existing user #{found_user.username}"
    else
      new_user = User.new(username: username)
      if new_user.save
        session[:user_id] = new_user.id
        flash[:success] = "Successfully created new user #{new_user.username} with ID #{new_user.id}"
      else
        flash.now[:warning] = "A problem occurred: Could not create user"
        render :login_form
        return
      end
    end

    return redirect_to root_path
  end
  
  def logout
    # TODO: What happens if we were never logged in?
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    return redirect_to root_path
  end
  
  def current
    @user = User.find_by(id: session[:user_id])
    unless @user
      flash[:warning] = "You must be logged in to see this page"
      redirect_to root_path
      return
    end
  end
  
end
