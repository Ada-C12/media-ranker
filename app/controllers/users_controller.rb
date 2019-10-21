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
            flash[:success] = "You are now logged in as #{username}"
        else
            user = User.create(username: username)
            session[:user_id] = user.id
            flash[:success] = "#{username} has been logged out"
        end
        
        redirect_to root_path
    end
    
    def current
        @current_user = User.find_by(id: session[:user_id])
        unless @current_user
            flash[:error] = "You must log in to see this page"
            redirect_to root_path
        end
    end
    
    def logout
        session[:user_id] = nil
        flash[:success] = "Grats, you're not here anymore"
        redirect_to root_path
    end
    
    
end
