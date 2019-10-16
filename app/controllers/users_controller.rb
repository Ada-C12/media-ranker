class UsersController < ApplicationController

  def index 
    @users = User.all
  end

  def show 
    #only available to a logged in user?
    @user = User.find_by(id: params[:id])
  end

  def login_form
    @user =  User.new
  end

  def login
    username = params[:user][:username]

    found_user = User.find_by(username: username)

    if found_user
      # We DID find a user!
      session[:user_id] = found_user.id
      flash[:message] = "Logged in as returning user!"
    else
      # We did not find an existing user. Let's try to make one!
      new_user = User.new(username: username)
      new_user.save
      # TODO: What happens if saving fails?
      session[:user_id] = new_user.id
      flash[:message] = "Created a new user. Welcome!"
    end
    return redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:message] = "You have logged out successfully."
    return redirect_to root_path
  end


end
