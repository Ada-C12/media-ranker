class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    user_id = params[:id].to_i
    @user = User.find_by(id: user_id)
    unless @user
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
      flash[:success] = "Successfully logged in as existing user #{found_user.username}!"
    else
      new_user = User.create(username: username)
      session[:user_id] = new_user.id
      flash[:success] = "Successfully created new user #{new_user.username} with ID #{new_user.id}"
    end
    redirect_to root_path
  end

  def current
    @current_user = User.find_by(id: session[:user_id])
    session[:user_id] = @user.id

    if @user.nil?
      head :not_found
    end
    # unless @current_user
    #   flash[:error] = "You must be logged in to see this page"
    #   redirect_to root_path
    # end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "You have logged out!"
    return redirect_to root_path
  end

  private

  def user_params
    return params.require(:user).permit(:username)
  end
end
