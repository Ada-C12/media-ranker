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
      raise
      @user.save
    else 
      render action: "login"
    end
    
  end
  
  
end
