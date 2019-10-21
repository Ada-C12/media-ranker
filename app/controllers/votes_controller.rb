class VotesController < ApplicationController
  before_action :find_user, only: [:index, :show, :create]
  before_action :find_work, only: [:index, :show, :create]

  def index
  end

  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.find_by(user_id: params[:user_id], work_id: params[:work_id])
    if @vote
      @vote.destroy
    else
      @vote = Vote.new
      @vote.work_id = params[:work_id]
      @vote.user_id = params[:user_id]
      @vote.save
    end
    redirect_to works_path
  end

  def not_logged_in_error
    flash[:not_logged_in] = "You must log in to vote"
    redirect_to works_path
  end

  private

  def work_params
    return params.require(:work).permit(:work_id, :user_id)
  end

  def find_user
    @user = User.find_by(id: session[:user_id])
  end

  def find_work
    @work = Work.find_by_id(:work_id)
  end
end
