class VotesController < ApplicationController
  def index
    @votes = Vote.all
  end

  def update
    @vote = Vote.find_by(id: params[:id])
    if @vote.nil?
      head :not_found
      return
    elsif @vote.update(vote_params)
      flash[:success] = "Successfully updated vote for #{vote.work.title}"
      redirect_to work_path(@vote.work_id)
      return
    else
      flash[:error] = "Vote NOT updated successfully"
      redirect_to :back
      return
    end
  end

  def create
    @vote = Vote.new(vote_params)
    
    if @vote.save
      flash[:success] = "Successfully voted for #{vote.work.title}"
      redirect_to votes_path
    else
      flash[:error] = "Vote NOT updated successfully"
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
      flash[:success] = "Successfully deleted vote for #{vote.work.title}"
      redirect_to votes_path
      return
    else
      redirect_to :back
    end
  end

  private
  def vote_params
    return params.require(:vote).permit(:work_id, :user_id)
  end

end