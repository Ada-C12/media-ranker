class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show

  end
  
  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:name]
    found_user = User.find_by(name: username)

    if found_user
      session[:user_id] = found_user.id
      flash[:success] = "Successfully logged in as existing user #{found_user.name}"
    else
      new_user = User.new(name: username)
      if new_user.save
        session[:user_id] = new_user.id
        flash[:success] = "Successfully created new user #{new_user.name} with ID #{new_user.id}"
      else
        flash.now[:error] = "A problem occurred: Could not log in"
        return render :login
      end
    end

    return redirect_to root_path
  end

  def logout
    #TODO add something if user was not logged in
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    return redirect_to root_path
  end

  def current
    @user = User.find_by(id: session[:user_id])
  end
end
