class UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def show
    user_id = params[:id].to_i
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
    
    found_user = User.find_by(username: username)
    
    if found_user
      session[:user_id] = found_user.id
      flash[:login] = "Logged in as returning user!"
    else
      new_user = User.new(username: username)
      new_user.save
      # TODO: What happens if saving fails?
      session[:user_id] = new_user.id
      flash[:login] = "Successfully created new user #{new_user.username} with ID #{new_user.id}"
    end
    
    return redirect_to root_path
  end
  
  def logout
    # TODO: What happens if we were never logged in?
    session[:user_id] = nil
    flash[:logout] = "You have logged out successfully."
    return redirect_to root_path
  end
  
  def current
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      head :not_found
      return
    end
    
  end
end


