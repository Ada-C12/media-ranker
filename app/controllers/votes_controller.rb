class VotesController < ApplicationController
  
  def index
    @votes = Vote.all
  end
  
  def create
    if session[:user_id]
      @user = User.find(session[:user_id])
      vote = Vote.new(user_id: @user.id, work_id: params[:work_id])
      vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_to works_path
    else
      flash.now[:error] = "You must log in to do that"
    end
    
  end
  
end
