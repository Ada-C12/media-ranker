class UsersController < ApplicationController
  
  def index
    @users = User.all.sort_by{ |user| - user.votes.length}
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
      
      if new_user.save
        session[:user_id] = new_user.id
        flash[:login] = "Successfully created new user #{new_user.username} with ID #{new_user.id}"
      else
        flash[:warning] = "Error: please try again"
        render login_form
      end
    end
    
    return redirect_to root_path
  end
  
  def logout
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


