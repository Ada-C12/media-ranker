class UsersController < ApplicationController
  
  def index
    # works but not tested
    @users = User.all.order(:id)
  end
  
  def login
    # works but not tested
    @user = User.new
  end
  
  def create
    # works but not tested
    
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
    # works but not tested
    @user = User.find_by(id: params[:id])
    unless @user
      head :not_found
    end
  end
  
end