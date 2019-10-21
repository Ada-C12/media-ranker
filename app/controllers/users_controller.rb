class UsersController < ApplicationController
  before_action :find_user_by_session, only: [:logout, :current]
  before_action :find_user_by_params, only: [:show, :destroy]

  def index
    @users = User.all
  end

  def show
    @user_id = params[:id].to_i
    if @user.nil?
      redirect_to user_path
      return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:username]
    @user = User.find_by(username: username)
    if @user
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in as returning user #{username}"
    else
      @user = User.create(username: username)
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in as new user #{username}"
    end
    redirect_to root_path
  end

  def current
    unless @user
      flash[:error] = "You must be logged in to see this page"
      redirect_to root_path
    end
  end

  def destroy
    if user.nil?
      redirect_to root_path
      return
    else
      votes = Vote.where(user_id: user.id)

      votes.each do |vote|
        vote.destroy
      end

      user.destroy
      redirect_to root_path
      return
    end
  end

  def logout
    if @user
      session[:user_id] = nil
      flash[:success] = "Successfully logged out as returning user #{@user.username}"
    else
      flash[:error] = "You are BAD "
    end
    redirect_to root_path
  end

  private

  def find_user_by_session
    @user = User.find_by(id: session[:user_id])
  end

  def find_user_by_params
    @user = User.find_by(id: params[:id])
  end
end
