class UsersController < ApplicationController
  def index 
    @users = User.alphabetic
  end

  def show
    @user = User.find_by(id: params[:id])
    
    if @user.nil?
      redirect_to root_path
      return 
    end
  end

  def login_form
    @user =  User.new
  end

  def login
    name = params[:user][:name]
    
    if name == ""
      flash[:failure] = "Name cannot be blank"
      redirect_to login_path
    else
      user = User.find_by(name: name)
      if user
        session[:user_id] = user.id
        flash[:success] = "Successfully logged in as returning user #{name}"
      else
        user = User.create(name: name)
        session[:user_id] = user.id
        flash[:success] = "Successfully logged in as #{name}"
      end  
      redirect_to root_path   
    end
  end

  def current
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      flash[:error] = "You must be logged in to see this page"
      redirect_to root_path
    end
  end
  
  def logout
    session[:user_id] = nil
    redirect_to root_path
  end
end
