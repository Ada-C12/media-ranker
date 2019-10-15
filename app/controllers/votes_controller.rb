class VotesController < ApplicationController
  def index
    @votes = vote.all
  end

  def update
    @vote = Vote.find_by(id: params[:id])
    if @vote.nil?
      head :not_found
      return
    elsif @vote.update(vote_params)
      redirect_to work_path(@vote.work_id)
      return
    else
      redirect_to :back
      return
    end
  end
  
  def destroy
    vote = Vote.find_by(id: params[:id])
    if vote.nil?
      head :not_found
      return
    elsif vote.destroy
      redirect_to votes_path
      return
    else
      redirect_to :back
    end
  end

  private
  def work_params
    return params.require(:vote).permit(:work_id, :user_id)
  end

end
