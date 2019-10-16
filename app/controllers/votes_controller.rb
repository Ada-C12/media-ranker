class VotesController < ApplicationController
  def upvote
    user = User.find_by(id: session[:user_id])
    if user.nil?
      flash.now[:warning] = "A problem occurred: You must log in to do that"
      return
    end
    
    work = Work.find_by(id: params[:work_id])
    if work.nil?
      head :not_found
      return
    end
  end
end
