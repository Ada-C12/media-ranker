class VotesController < ApplicationController
  
  def create
    date = Date.today
    @vote = Vote.create(user_id: session[:user_id], work_id: params[:work_id], created_at: date)
    
    if @vote.save
      redirect_to work_path(params[:work_id])
    else 
      flash[:warning] = "A problem occured: You already voted for this work."
      redirect_to root_path
    end
  end 
  
  
  def destroy
  end
  
  private 
  
  def vote_params
    return params.require(:vote).permit(:user, :work, :created_at)
  end 
end
