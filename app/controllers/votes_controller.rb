class VotesController < ApplicationController
  def create
    work = Work.find_by(id: params[:work_id])
    user = User.find_by(id: session[:user_id])
    if work.nil? || user.nil?
      head :not_found 
      return
    end
    
    @vote = Vote.new(work_id: work.id, user_id: user.id)
    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_to work_path(work.id)
      return
    else
      flash[:error] = "A problem occurred: Could not upvote"
      redirect_to work_path(work.id)
      return
    end
  end
end
