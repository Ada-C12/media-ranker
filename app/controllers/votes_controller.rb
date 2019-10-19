class VotesController < ApplicationController
  
  
  def create
    current_user = User.find_by(id: session[:user_id])
    @work = Work.find_by(id: params[:id])
    
    @vote = Vote.create(user_id: current_user.id, work_id: @work.id)
    if @vote
      flash[:message] = "Successfully upvoted!"
    else
      flash[:message] = "You're bad at this."
    end
  end
  private
  def vote_params
    params.require(:vote)
  end
end