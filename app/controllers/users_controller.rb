class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    user_username = params[:user][:username]
    user = User.find_by(username: user_username)
    if user.nil?
      # create new user
      @user = User.create(username: user_username)
      if @user.errors.any?
        flash.now[:alert_class] = "warning"
        flash.now[:warning] = "errors: #{@user.errors.first}"
        render :login_form
        return
      else
      session[:user_id] = user.id
      flash[:alert_class] = "success"
      flash[:success] = "Successfully created new user #{user.username} with ID #{user.id}"
      end
    else
      session[:user_id] = user.id
      flash[:alert_class] = "success"
      flash[:success] = "Successfully logged in as existing user #{user.username}"
    end
    redirect_to root_path
  end

  def current
    @current_user = User.find_by(id: session[:user_id])
    if @current_user.nil?
      flash[:error] = "You have to be logged in to see that page"
      redirect_to root_path
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Logged out"
    redirect_to root_path
  end

end
