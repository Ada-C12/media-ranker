class UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def show
    user_id = params[:id].to_i
    @user = User.find_by(id:user_id)
    if @user.nil?
      redirect_to users_path
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
      flash[:message] = "Successfully logged in as existing user #{found_user.username}"
      return redirect_to root_path
    else
      @user = User.new(username: username)
      if @user.save
        session[:user_id] = @user.id
        flash[:message] = "Successfully created new user #{@user.username} with ID #{@user.id}"
        return redirect_to root_path
      else
        render :login_form
      end
    end
    
  end
  
  def logout
    session[:user_id] = nil
    flash[:message] = "Successfully logged out"
    return redirect_to root_path
  end
  
  # def current
  #   @user = User.find_by(id: session[:user_id])
  # end
end
