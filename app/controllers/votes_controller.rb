class VotesController < ApplicationController
  def create
    current_user = User.find_by(id: session[:user_id])
    work = Work.find_by(id: params[:work_id])

    if current_user
      @vote = Vote.new(user: current_user, work: work)
      if @vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_back(fallback_location: :back)
        return
      else
        #how can I make this a flash.now?
        #need render for error message?
        flash[:error] = "A problem occurred: Could not upvote"
        redirect_back(fallback_location: :back)
        return
      end
    else
      flash[:error] = "A problem occurred: You must log in to do that"
      redirect_back(fallback_location: :back)
      return
    end

  end
end
