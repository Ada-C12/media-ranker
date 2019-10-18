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
    user = User.find_by(username: username)
    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as returning user #{username}"
    else
      user = User.create(username: username)
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as new user #{username}"
    end
  
    redirect_to root_path
  
  end
 
  def logout
    @user = User.find_by(id: session[:user_id])

    if @user
      session[:user_id] = nil
      flash[:success] = "Successfully logged out"
    else
      flash[:error] = "Unsuccessfully logged out"
    end
    redirect_to root_path
  end 

  private
  def user_params
    return params.require(:user).permit(:username)
  end

end
