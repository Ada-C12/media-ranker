class VotesController < ApplicationController

  def create
    @work = Work.find_by(id:params[:work_id])
    vote_params = @work.upvote
    @vote = Vote.create(vote_params)

    if @vote
      redirect_to work_path(@work.id)
      
    else
      render root_path
    end 
  end 

  private
  def vote_params
    return params.require(:vote).permit(:user_id, :work_id, :date_voted)
  end 

end
