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
      redirect_to work_path(params[:work_id])
    else
      flash[:error] = "You can only vote once for each work!"
      redirect_to root_path
    end
  end

end
