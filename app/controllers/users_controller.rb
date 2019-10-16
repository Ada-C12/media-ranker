class UsersController < ApplicationController
  
  def login_form
    @user = User.new
  end
  
  def login
    username = params[:user][:username]
    
    found_user = User.find_by(username: username)
    
    if found_user
      session[:user_id] = found_user.id
      flash[:message] = "Logged in as returning user!"
    else
      new_user = User.new(username: username)
      new_user.save
      # TODO: What happens if saving fails?
      session[:user_id] = new_user.id
      flash[:message] = "Created a new user. Welcome!"
    end
    
    return redirect_to root_path
  end
  
  def logout
    # TODO: What happens if we were never logged in?
    session[:user_id] = nil
    flash[:message] = "You have logged out successfully."
    return redirect_to root_path
  end
  
  def current
    @user = User.find_by(id: session[:user_id])
  end
  
end
