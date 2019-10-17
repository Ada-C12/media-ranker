class VotesController < ApplicationController
  
  def create
    @vote = Vote.new(vote_params) #instantiate a new vote
    if @vote.save # save returns true if the database insert succeeds
      flash[:success] = "Successfully upvoted!"
      redirect_to root_path
      # should probably redirect to work page but we don't know that at the moment
      return
    else 
      flash.now[:failure] = "Vote failed :("
      redirect_to root_path
      # should probably redirect to work page but we don't know that at the moment
      return
    end
    
  end
  
  private
  
  def vote_params
    return params.require(:vote).permit(:work_id, :user_id)
  end
  
end
