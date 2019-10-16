class VotesController < ApplicationController
  def upvote
    user = User.find_by(id: session[:user_id])
    
    if user.nil?
      flash[:warning] = "A problem occurred: You must log in to do that"
      redirect_back(fallback_location: root_path)
      return
    end
    
    work = Work.find_by(id: params[:work_id])
    
    if work.nil?
      head :not_found
      return
    end
    
    @vote = Vote.new(work_id: work.id, user_id: user.id)
    
    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_back(fallback_location: root_path)
      return
    else
      flash[:warning] = "A problem occurred: Could not upvote. #{@vote.errors.messages}"
      redirect_back(fallback_location: root_path)
      return
    end
  end
end
