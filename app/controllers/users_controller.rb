class UsersController < ApplicationController

  skip_before_action :determine_user, except: [:new, :create]


    def index
      @users = User.all
    end

    def show
      user_id = params[:id].to_i
      @user = User.find_by(id: user_id)

      @user_votes = Vote.where(user_id: user_id)

      if @user_votes.length > 0
        @user_votes.each do |vote|
        @works = Work.find_by(id: vote.work_id)
        end
      end
    end

    def login_form
        @user = User.new
    end

    def login
        username = params[:user][:username] # params = {"user": {"username": "sara"}}
        user = User.find_by(username: username)

        
        if user
          session[:user_id] = user.id # session = {"user_id": 1}
          flash[:success] = "Successfully logged in as returning user #{username}!"
        else
          new_user = User.create(username: username)
          session[:user_id] = new_user.id
          flash[:success] = "Successfully logged in as new user #{username}!"
        end
      
        redirect_to root_path
    end

    def current
        @current_user = User.find_by(id: session[:user_id])
        unless @current_user
          flash[:error] = "You must be logged in to see this page"
          redirect_to root_path
        end
    end


    def logout  
      # what if we are never logged in?
      session[:user_id] = nil
      flash[:success] = "You have logged out successfully"
      redirect_to root_path
    end

    # def signup
    #   username = params[:user][:username]
    #   user = User.new(username: username)

    #   if save
    #     redirect_to root_path
    #   end

    # end

end
