class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    user_id = params[:id].to_i
    @user = User.find_by(id: user_id)
    if @user.nil?
      head :not_found
      return
    end
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "#{@user.username} created successfully"
      redirect_to user_path(@user.id)
    else
      flash.now[:error] = "Work NOT created successfully"
      render new_user_path
      return
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
      
    if @user.nil?
      head :not_found
      return
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.nil?
      head :not_found
      return
    elsif @user.update(user_params)
      flash[:success] = "#{@user.username} updated successfully"
      redirect_back(fallback_location: user_path(@user.id))
      return
    else
      flash.now[:error] = "Work NOT updated successfully"
      render edit_user_path
      return
    end
  end

  def destroy
    user = User.find_by(id: params[:id])
    if user.nil?
      redirect_to root_path
      return
    elsif user.destroy
      session[:user_id] = nil if session[:user_id] == user.id
      flash[:success] = "#{user.username} updated successfully"
      redirect_back(fallback_location: users_path)
      return
    else
      flash[:error] = "Work NOT deleted successfully"
      redirect_back(fallback_location: users_path)
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
      flash[:success] = "Welcome back #{username}! You are successfully logged in."
      redirect_to root_path
    else
      user = User.new(username: username)
      if user.save
        session[:user_id] = user.id
        flash[:success] = "Welcome to MediaRanker #{username}! You are successfully logged in."
        redirect_to root_path
      else
        flash[:error] = "Did NOT successfully log in new user"
        render login_form_path
      end
    end
  end

  def logout
    user_id = session[:user_id]
    user = User.find_by(id: user_id)
    if user
      session[:user_id] = nil
      flash[:success] = "Successfully logged out user #{user.username}"
      redirect_to root_path
    else
      flash[:error] = "Did NOT successfully log out user"
      redirect_to root_path
    end
  end

  def current
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      flash[:error] = "You must be logged in to see this page"
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def user_params
    return params.require(:user).permit(:username)
  end

end
