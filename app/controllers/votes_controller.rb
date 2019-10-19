class VotesController < ApplicationController
  def create
    work = Work.find_by(id: params[:work_id])
    user = User.find_by(id: session[:user_id])
    
    
    if user.nil? # If there is no user signed in
      flash[:warning] = "A problem occurred: You must log in to do that."
        redirect_to works_path
        return
      elsif work.votes.find_by(user_id: user.id) # If this user has already voted for the work
        flash[:failure] = "Could not upvote. #{user.username} has already voted for this work."
        redirect_to works_path
        return
      end
      
      vote = Vote.new(user_id: user.id, work_id: work.id)
      if vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_to works_path
        return
      else
        flash.now[:failure] = "Upvote failed."
      end 
    end
  end
  