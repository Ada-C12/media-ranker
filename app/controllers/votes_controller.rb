class VotesController < ApplicationController
  def create
    vote = Vote.where(:user => session[:user_id], :work => params[:work_id] )
    if vote # already voted
      flash[:error] = "You have already voted for this work!"
    else
    @vote = Vote.create(date: Date.today)
    end
  end
end
