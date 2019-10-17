class VotesController < ApplicationController

  def create
    @work = Work.find_by(id:params[:work_id])
    current_user = User.find_by(id: session[:user_id])
    if current_user.nil? 
      flash[:error] = "You must be logged in to do that"
      redirect_to work_path(@work.id)
      return
    elsif current_user.votes.any? { |vote| vote.work_id == @work.id } == true 
      flash[:error] = "You can't vote for something again silly"
      redirect_to work_path(@work.id)
      return
    end
    vote_params = @work.upvote(current_user)
    @vote = Vote.create(vote_params)

    if @vote
      redirect_to work_path(@work.id)
      flash[:success] = "Successfully upvoted work #{@work.title}"
    else
      render root_path
    end 
  end 

  private
  def vote_params
    return params.require(:vote).permit(:user_id, :work_id, :date_voted)
  end 

end
