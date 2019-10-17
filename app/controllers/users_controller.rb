class UsersController < ApplicationController

  def index
    @users = User.all
  end 

  def show 
    user_id = params[:id].to_i
    @user = User.find_by(id:params[:id])
    if @user.nil?
      head :not_found 
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

  # def login_form
  #   @user = User.new
  # end 

  # def login
  #   username = params[:user][:username]
  #   user = User.find_by(username: username)
  #   if user
  #     session[:user_id] = user.id
  #     flash[:success] = "Successfully logged in as returning user #{username}"
  #   else
  #     user = User.create(username: username)
  #     session[:user_id] = user.id
  #     flash[:success] = "Successfully logged in as new user #{username}"
  #   end
  
  #   redirect_to root_path
  # end

  # def current
  #   @current_user = User.find_by(id: session[:user_id])
  #   unless @current_user
  #     flash[:error] = "You must be logged in to see this page"
  #     redirect_to root_path
  #   end
  # end

  # def logout
  #   @current_user = User.find_by(id: session[:user_id])
  #   if @current_user.nil? 
  #     flash[:error] = "You must be logged in to logout"
  #   else 
  #     session[:user_id] = nil
  #     flash[:logged_out] = "Successfully logged out" 
  #     redirect_to root_path
  #   end 
  # end 


  private
  
  def user_params
    return params.require(:user).permit(:username)
  end
end
