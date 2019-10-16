class UsersController < ApplicationController
  
  def index
    # works but not tested
    @users = User.all.order(:id)
  end
  
  def login
    @user = User.new
  end
  
  def create
    # works but not tested
    
    name_input = params[:user][:name]
    @user = User.new(name: name_input, votes_casted: 0)
    
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged #{@user.name} in as a new user!"
      redirect_to user_path(@user.id)
      return
      
    else 
      @existing_user = User.find_by(name: name_input)
      if @existing_user
        @user = @existing_user
        session[:user_id] = @user.id
        flash[:success] = "Welcome back, #{@user.name}"
        redirect_to user_path(@user.id)
        return
      else
        # bogus input 
        flash.now[:error] = "Login unsuccessful!"
        render action: "login"
        return
      end
    end
  end
  
  def show
    # works but not tested
    @user = User.find_by(id: params[:id])
    # using params[:id] instead of session[:user_id], not as secure for user privacy, but we dont' care for thsi project
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
  
  # REDUNDANT
  # def self.user_from_session 
  #   if session[:user_id]
  #     user = User.find_by(id: session[:user_id])
  #     user ? (return user):(return nil)
  #   else
  #     return nil
  #   end
  # end
  
end