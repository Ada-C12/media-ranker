class VotesController < ApplicationController
  def create
    vote = Vote.where(:user => session[:user_id], :work => params[:work_id] )
    if vote # already voted
      flash[:error] = "Sorry, you may only vote once for this work!"
    else
    vote = Vote.create(date: Date.today)
    end
  end
end
