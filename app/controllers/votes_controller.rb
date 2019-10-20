class VotesController < ApplicationController

  def create
    unless session[:user_id]
      flash[:error] = "You must be logged in to vote!"
      redirect_to root_path
      return
    end

    vote = Vote.create(work_id: params[:work_id], user_id: session[:user_id])
    vote.save
    
    if vote.save
      flash[:success] = "Successfuly upvoted!"
      redirect_to work_path(params[:work_id])
    else
      flash[:error] = "A problem occurred: Could not upvote"
      redirect_to root_path
    end
  end

end
