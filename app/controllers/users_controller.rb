class UsersController < ApplicationController
  
  def index
    @users = User.all.ord(:id)
  end
  
  def login
  end
  
end
