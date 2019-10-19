class VotesController < ApplicationController

  def create
    user = User.find_by(id: session[:user_id])
    @work = Work.find_by(id: params[:work_id])
    vote = Vote.new(work_id: params[:work_id], user_id: user.id, date: Time.now)

    if @work.votes.find_by(user_id: user.id) == nil 
      vote.save
      flash[:success] = "Successfully voted!"
    elsif session[:user_id] == nil
      flash.now[:failure] = "A problem occurred: You must log in to do that"
    else 
      flash[:failure] = "You cannot vote more than once for same work."
    end
    redirect_to works_path
  end

end
