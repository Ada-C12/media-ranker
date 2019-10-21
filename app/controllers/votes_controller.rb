class VotesController < ApplicationController
  
  def index
    
  end
  
  def create
    vote = Vote.create(vote_params)
  end
  
  def vote_params
    params.require(:vote).permit(:user_id, :work_id)
  end
  
  def vote
    @current_user = User.find_by(id: session[:user_id])
    @current_work = Work.find_by(id: params[:id])
    if @current_user.nil? 
      flash[:error] = "you are not logged in"
      redirect_to root_path
    elsif !Vote.new(user_id: @current_user.id, work_id: @current_work.id).valid?
      flash[:error] = "you have already voted for this work"
      redirect_to work_path(@current_work)
    else
      vote = Vote.create(user_id: @current_user.id, work_id: @current_work.id)
      flash[:success] = "You have now voted for this work"
      redirect_to work_path(@current_work)
    end
  end
  
end#end of class
