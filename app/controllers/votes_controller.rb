class VotesController < ApplicationController
  def create
    current_user = session[:user_id]
    work = params[:work_id]

    unless current_user
      flash[:warning] = "A problem occured: You must log in to do that"
      redirect_to work_path(work)
      return
    end

    if Vote.find_by(user_id: current_user, work_id: work)
      flash[:warning] = "A problem occurred: You have already voted for this work"
      redirect_to work_path(work)
      return
    else
      vote = Vote.new
      vote.user_id = current_user
      vote.work_id = work
      vote.save
      flash[:success] = "You have successfully voted for this work!"
      redirect_to work_path(work)
      return
    end
  end
end
