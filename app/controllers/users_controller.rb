class UsersController < ApplicationController
  def login_form
    @user = User.new
  end
  
  def login
    @username = params[:user][:username] 
    @user = User.find_by(username: @username)
    
    if @user
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in as existing user #{@username}"
    else
      @user = User.new(username: @username)
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Successfully created new user #{@username} with ID #{@user.id}"
      else
        flash.now[:warning] = "A problem occurred: Could not log in"
        
        if @user.errors.any?
          @user.errors.each do |column, message| 
            flash.now[column.to_sym] = message
          end
        end
        
        render :login_form  
        return
      end
    end
    
    redirect_to root_path
  end
  
  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end
  
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
end
