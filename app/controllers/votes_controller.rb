class VotesController < ApplicationController

  def create
    work = Work.find_by(id: params[:work_id])
    vote_params = vote.upvote
    @vote = Vote.create(vote_params)
  end

  private

  def vote_params
    return params.require(:vote).permit(:date_voted, :user_id, :work_id)
  end
end
