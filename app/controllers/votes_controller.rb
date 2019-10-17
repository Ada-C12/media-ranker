class VotesController < ApplicationController
  def create
    work = Work.find_by(id: params[:work_id])
    if work.nil?
      head :not_found 
      return
    end

    user = User.find_by(id: session[:user_id])
    if user.nil?
      flash[:error] = "A problem occurred: You must log in to do that"
      redirect_back(fallback_location: :back)
      return
    end

    @vote = Vote.new(work_id: work.id, user_id: user.id)

    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_back(fallback_location: :back)
      return
    else
      flash[:error] = "A problem occurred: Could not upvote"
      redirect_back(fallback_location: :back)
      return
    end
  end
end
