class VotesController < ApplicationController
  
  def vote_by_work_id 
    @work = Work.find(params[:id])
    @user = User.find(session[:user_id])
    
    vote = Vote.new
    vote.work_id = @work.id
    vote.user_id = @user.id
    successful = vote.save
    
    redirect_to root_path
    
    Vote.find_by user_id: vote_by_work_id
  end
end