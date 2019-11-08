class VotesController < ApplicationController

  def create
    if session[:user_id] != nil  
      user = User.find_by(id: session[:user_id])
      @work = Work.find_by(id: params[:work_id])
      vote = Vote.new(work_id: params[:work_id], user_id: user.id, date: Time.now)
      if @work.votes.find_by(user_id: user.id) == nil
        vote.save
        flash[:success] = "Successfully voted!"
        new_votes_total = @work.total_votes + 1
        @work.update(total_votes: new_votes_total)
      else 
        flash[:failure] = "You cannot vote more than once for same work."
      end
    else
      flash[:failure] = "A problem occurred: You must log in to do that"
    end   
    redirect_to works_path
  end
end
