class UsersController < ApplicationController
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
      @user = User.create(username: username)
      
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Successfully logged in as new user #{username}"
      else
        render :login_form
        return
      end
    end
    
    redirect_to root_path
  end
  
  def current
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      flash[:error] = "You must be logged in to view this page."
      redirect_to root_path
    end
  end
  
  def logout
    flash[:success] = "Sucecssfully logged out."
    session[:user_id] = nil
    redirect_to root_path
  end
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find_by(id: params[:id])
  end
  
  private
  
  def user_params
    return params.require(:work).permit(:username)
  end
end

