class VotesController < ApplicationController
  def upvote
    @work = Work.find_by(id: params[:id])
    @new_user = User.find_by(id: session[:user_id])
    if session[:user_id] == nil
      flash[:error] = "A problem occurred: You must log in to do that"
      redirect_to request.referrer
      return
    end

    if @work.upvote(session[:user_id])
      flash[:success] = "Successfully upvoted!"
      redirect_to request.referrer
    else
      @new_user.errors.add(:user, "has already voted for this work")
      # raise
      flash[:error] = "A problem occurred: Could not upvote!"
      redirect_to request.referrer
    end
  end
end
