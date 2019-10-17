class VotesController < ApplicationController
  # def create
  #   if params[:work_id]
  #     work = Work.find_by(id: params[:work_id])
  #     if work.votes.find_by(user: session[:user_id]).nil?
  #     @vote = work.votes.new
  #     @vote.save
  #     end
  #   end
  # end
  # def create
  #   vote = Vote.where(:user => session[:user_id], :work => params[:work_id] )
  #   if vote != nil # already voted
  #     flash[:error] = "Sorry, you may only vote once for this work!"
  #   else
  #   vote = Vote.create(date: Date.today)
  #   work = Work.find(params[:work_id])
  #   p work
  #   user = User.find(session[:user_id])
  #   p user
  #   work.votes << vote
  #   user.votes << vote
  #   p work.votes
  #   p user.votes
  #   end
  # end
end
