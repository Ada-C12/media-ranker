class VotesController < ApplicationController
  
  def index
    @votes = Vote.all
  end
  
  def create
    if session[:user_id]
      @user = User.find(session[:user_id])
      @vote = Vote.new(user_id: @user.id, work_id: params[:work_id])
      if @vote.save
        flash[:success] = "Successfully upvoted!"
      else
        flash[:error] = {
          "name" => "Could not upvote",
          "message" => "user: has already voted for this work"
        }
      end
      redirect_to works_path
    end    
  end
  
end
