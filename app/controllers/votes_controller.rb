class VotesController < ApplicationController
  def create
    vote = Vote.where(:user => session[:user_id], :work => params[:work_id] )
    if vote # already voted
      flash[:error] = "Sorry, you may only vote once for this work!"
    else
    vote = Vote.create(date: Date.today)
    work = Work.find(params[:work_id])
    user = User.find(session[:user_id])
    work.votes << vote
    user.votes << vote
    end
  end
end
