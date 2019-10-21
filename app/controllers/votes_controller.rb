class VotesController < ApplicationController
  
  def index
    
  end
  
  def create
    vote = Vote.create(vote_params)
  end
  
  def vote_params
    params.require(:vote).permit(:user_id, :work_id)
  end
  
  def upvote
    current_user = User.find_by(id: session [:user_id])
    current_work = Work.find_by(id: params[:id])
    
    if Vote.where(work_id: current_work.id).length != 0 #has to start at 0 or this has already been voted for
      flash[:error] = "you have already voted for this work"
      redirect_to work_path(current_work)
      return #the thing devin said we needed
    end
    
    if current_user
      vote = Vote.new(user_id: current_user.id, work_id: current_work.id)
      if vote.save 
        flash[:success] = "You have now voted for this work"
      else
        flash[:error] = "Sorry, you have already voted for this work"
      end
      redirect_to work_path(current_work)
    end
    
  end#end of class
  