class UsersController < ApplicationController
  
  def index
    @users = User.all.order(:id)
  end
  
  def login
    @user = User.new
  end
  
  def create
    # This runs when user tries to log in
    name_input = params[:user][:name]
    
    # First, is the user an existing user?
    @existing_user = User.find_by(name: name_input)
    if @existing_user
      @user = @existing_user
      session[:user_id] = @user.id
      flash[:success] = "Welcome back, #{@user.name}"
      redirect_to user_path(@user.id)
      return
      
    else 
      # If new user, add to database
      @user = User.new(name: name_input)
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Successfully logged #{@user.name} in as a new user!"
        redirect_to user_path(@user.id)
        return
      else
        # bogus input 
        flash.now[:error] = "Login unsuccessful! #{list_error_messages(@user)}"
        render action: "login"
        return
      end
    end
  end
  
  def show
    # why params[:id] and not session[:id]? b/c I want to show page even if you're not logged in
    @user = User.find_by(id: params[:id])
    unless @user
      flash[:error] = "User does not exist!"
      redirect_to root_path
      return
    end
  end
  
  def logout
    user = User.find_by(id: session[:user_id])
    flash[:success] = "Successfully logged out #{user.name}"
    session[:user_id] = nil
    redirect_to root_path
    return
  end
  
end