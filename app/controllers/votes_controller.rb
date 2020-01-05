class VotesController < ApplicationController
  
  def create
    @vote = Vote.new(work_id: params[:id], user_id: session[:user_id])
    if session[:user_id] == nil
      flash[:warning] = "You must be logged in to vote."
      redirect_to work_path
      return
    elsif session[:user_id]
      if Vote.where(user_id: session[:user_id], work_id: params[:id]).count != 0
        flash[:warning] = "You can only vote once for a work."
        redirect_to work_path
      elsif @vote.save # save returns true if the database insert succeeds
        flash[:success] = "Successfully upvoted!"
        redirect_to work_path
        # eventually the work page will show the new vote 
        return
      else 
        flash.now[:failure] = "Vote failed :("
        redirect_to work_path
        return
      end
    end
    
  end
  
  private
  
  def vote_params
    return params.require(:vote).permit(:work_id, :user_id)
  end
  
end
