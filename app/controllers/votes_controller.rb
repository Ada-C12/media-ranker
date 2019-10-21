class VotesController < ApplicationController
  def index
    @votes = Vote.all
  end
  
  def show
    vote_id = params[:id]
    @vote = Vote.find_by(id: vote_id)
    
    if @vote.nil?
      flash[:error] = "Could not find vote ID #{ params[:id] }"
      re  direct_to votes_path
      return
    end 
  end
  
  def new
    if params[:id]
      work = Work.find_by(work_id: work.id)
      @vote = work.votes.new
    else
      @vote = Vote.new
    end 
  end
  
  def create
    params[:work_id]
    @vote = Vote.new(
      user_id: session[:user_id],
      work_id: params[:work_id],
    )
    
    if @vote.save
      flash[:success] = "You have successfully voted"
      redirect_to works_path
      return
    else
      flash[:danger] = "You need to log in to vote; You can't vote for the same media twice"
      redirect_to works_path
      return
    end
  end
  
  def edit
    @vote = Vote.find_by(id: params[:id])
    
    if @vote.nil?
      flash[:error] = "Could not find vote ID #{ @vote.id }"
      redirect_to votes_path
      return
    end 
  end
  
  def update
    @vote = Vote.find_by(id: params[:id])
    
    if @vote.update(vote_params)
      redirect_to vote_path(@vote)
      return
    else 
      render :edit
      return
    end
  end
  
  def destroy
    @vote = Vote.find_by(id: params[:id])
    
    if @vote.nil?
      flash[:error] = "Could not find vote ID #{ @vote.id }"
      redirect_to votes_path
      return
    end 
    
    @vote.destroy
    redirect_to votes_path
    return
  end
  
  private
  
  def vote_params
    return params.require(:vote).permit(:work_id, :user_id)
  end
  
end
