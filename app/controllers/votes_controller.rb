class VotesController < ApplicationController
  
  
  def create
    current_user = User.find_by(id: session[:user_id])
    work_id = params[:work_id]
    
    if current_user.nil?
      flash[:warning] = "You must be signed in"
      redirect_to login_path
      return
    end
    
    vote = Vote.new(user_id: current_user.id, work_id: work_id)
    if vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_back(fallback_location: root_path)
    else # save failed :(
      flash[:failure] = "Error: You can't vote for the same work twice!"
      redirect_back(fallback_location: works_path)
      return
    end
  end
  
end



