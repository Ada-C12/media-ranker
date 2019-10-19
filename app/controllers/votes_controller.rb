class VotesController < ApplicationController
  
  
  def create
    current_user = User.find_by(id: session[:user_id])
    
    if current_user == nil
      flash.now[:message] = "You must be logged in to vote!"
      return redirect_to root_path
    end
    
    @work = Work.find_by(id: params[:id])
    @vote = Vote.new(user_id: current_user.id, work_id: @work.id)
    
    if @vote.save
      flash[:message] = "Successfully upvoted!"
      redirect_to root_path
    else
      flash[:message] = "You can only vote for one work once! "
      redirect_to root_path
      return
      
    end
  end
  
  
  private
  def vote_params
    params.require(:vote)
  end
end