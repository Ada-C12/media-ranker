class VotesController < ApplicationController
  
  def create
    date = Date.today
    @vote = Vote.create(user_id: session[:user_id], work_id: params[:work_id], created_at: date)
    
    redirect_to work_path(params[:work_id])
  end 
  
  
  def destroy
  end
  
  private 
  
  def vote_params
    return params.require(:user, :work, :created_at)
  end 
end
