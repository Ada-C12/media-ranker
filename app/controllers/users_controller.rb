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
      flash[:message] = "Logged in as returning user!"
      return redirect_to root_path
    else
      @user = User.new(username: username)
      if @user.save
        session[:user_id] = @user.id
        flash[:message] = "Created a new user. Welcome!"
        return redirect_to root_path
      else
        render :login_form
      end
    end
    
  end
  
  def logout
    session[:user_id] = nil
    flash[:message] = "You have logged out successfully."
    return redirect_to root_path
  end
  
  # def current
  #   @user = User.find_by(id: session[:user_id])
  # end
end
