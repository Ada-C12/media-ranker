class VotesController < ApplicationController
  def create
    work = Work.find_by(id: params[:work_id])
    user = User.find_by(id: session[:user_id])
    
    if user.nil?
      flash.now[:failure] = "A problem occurred: You must log in to do that."
        redirect_to work_path
      elsif work.votes.find_by(user_id: user.id)
        flash.now[:failure] = "Could not upvote. #{user.username} has already voted for this work."
        render :new
        return
      else
        Vote.new(user_id: user.id, work_id: work.id)
        flash[:success] = "Successfully upvoted!"
        redirect_to works_path
      end 
    end
  end
  