class UsersController < ApplicationController
    
    def index
        @users = User.all
    end
    
    def show
        @user = User.find_by(id: params[:id])
        if @user.nil?
            flash[:error] = "That user does not exist"
            redirect_to new_user_path
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
            flash[:success] = "You are now logged in as #{@user.username}"
        else
            user = User.create(username: username)
            session[:user_id] = user.id
            flash[:success] = "User #{@user.username} has been created. You are now logged in as #{username}"
        end
        
        redirect_to root_path
    end
    
    def current
        @current_user = User.find_by(id: session[:user_id])
    end
    
    def logout
        @user = User.find_by(id: session[:user_id])
        if @user
            session[:user_id] = nil
            flash[:success] = "User #{@user.username} has been logged out"
            redirect_to root_path 
        end
    end   
    
end

