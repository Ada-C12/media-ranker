class VotesController < ApplicationController

  def create
    
    if session[:user_id]
      work = Work.find_by(id: params[:id])
      user = User.find_by(id: session[:user_id])
      if Vote.create(work: work, user: user)
        flash[:success] = "Successfully upvoted!"
        redirect_back(fallback_location: :back)
      else
        flash[:error] = "A problem occurred: Could not upvote"
        redirect_back(fallback_location: :back)
      end
    else
      flash[:error] = "A problem occurred: You must log in to do that"
      redirect_back(fallback_location: :back)
    end
    

  end
end
