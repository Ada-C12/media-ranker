class UsersController < ApplicationController
  
  def index
    @users = User.all.order(:id)
  end
  
  def login
    @user = User.new
  end
  
  def create
    name_input = params[:user][:name]
    @user = User.new(name: name_input, votes_casted: 0)
    
    if @user.valid?
      # new user
      @user.save
      
    else 
      @existing_user = User.find_by(name: name_input)
      if @existing_user
        # user already exists
        redirect_to user_path(@existing_user)
      else
        # bogus input 
        render action: "login"
      end
    end
    
  end
end