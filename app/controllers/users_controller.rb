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
      @user.save
      redirect_to user_path(@user.id)
      
    else 
      @existing_user = User.find_by(name: name_input)
      if @existing_user
        @user = @existing_user
        redirect_to user_path(@user.id)
      else
        # bogus input 
        render action: "login"
      end
    end
  end
  
  def show
    @existing_user = params[:id]
  end
end