class VotesController < ApplicationController
  before_action :current_user

  def index
    @votes = Vote.all
  end

  def new
    @vote = Vote.new
  end

  def create
    work_id = params[:work_id]
    user_id = session[:user_id]

    if !session[:user_id]
      flash[:failure] = "Please Log In to Vote."
      redirect_back(fallback_location: root_path)
      return 
    end

    if Vote.where(user_id: user_id, work_id: work_id).count > 0
      flash[:failure] = "You already voted for #{Work.find_by(id: work_id).title}."
      redirect_back(fallback_location: root_path)
      return
    end

    vote = Vote.create(user_id: user_id, work_id: work_id)
    flash[:success] = "Vote added successfully."
    redirect_back(fallback_location: root_path)
    return
  end

  def show
  end

end
