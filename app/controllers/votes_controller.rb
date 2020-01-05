
class VotesController < ApplicationController
  
  def new
    @vote = Vote.new
  end
  
  def create
    if session[:user_id].nil?
      flash[:failure] = {general:"A problem occurred: You must log in to do that"}
      redirect_to works_path
    else
      vote_info = {
        date: Time.now,
        user_id: session[:user_id],
        work_id: work_id
      }
      if Vote.where(user_id: session[:user_id], work_id: work_id).exists?
        flash[:failure] = {general:"A problem occurred: Could not upvote", user: "user: has already voted for this work"}
        redirect_to works_path
      else
        @vote = Vote.new(vote_info) 
        if @vote.save
          flash[:success] = "Successfully upvoted" 
          redirect_to works_path
          return
        else
          render :new
          return
        end
      end
    end
  end

  private
	def work_id
    return params.require(:work_id)
  end
end
