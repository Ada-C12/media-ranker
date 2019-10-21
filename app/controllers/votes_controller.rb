class VotesController < ApplicationController
  def upvote
    @work = Work.find_by(id: params[:id])
    if session[:user_id] == nil
      flash[:error] = "A problem occurred: You must log in to do that"
      redirect_to request.referrer
      return
    end
    if @work.upvote(session[:user_id])
      flash[:success] = "Successfully upvoted!"
      redirect_to request.referrer
      return
    else
      flash[:errors] = []
      flash[:errors] << "A problem occurred: Could not upvote"
      flash[:errors] << "user: has already voted for this work"
      redirect_to request.referrer
      return
    end
  end
end
