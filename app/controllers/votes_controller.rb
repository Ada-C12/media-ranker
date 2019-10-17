# To make a vote, we need one vote and one user

class VotesController < ApplicationController
  
  def index
    @votes = Vote.all
  end
  
  def show
    vote_id = params[:id].to_i
    @vote = Vote.find_by(id: vote_id)
    if @vote.nil?
      head :not_found
      return
    end
  end
  
  
  def create
    # check to see if there is a current user, if not flash error message
    current_user = User.find_by(id: session[:user_id])
    vote_params = Work.upvote(current_user)
    
    @vote = Vote.new( vote_params )
    
    if @vote.save
      redirect_to vote_path(@vote.id)
    else
      render new_vote_path
    end
  end
  
  def edit
    @vote = Vote.find_by(id: params[:id] )
    if @vote.nil?
      redirect_to votes_path
      return
    end
  end
  
  def update
    @vote = Vote.find_by(id: params[:id] )
    if @vote.nil?
      head :not_found
      return
    elsif @vote.update( vote_params )
      redirect_to vote_path(@vote.id)
    else
      render :edit
    end
  end
  
  def destroy
    
    @vote = Vote.find_by( id: params[:id] )
    
    if @vote.nil?
      redirect_to votes_path
      return
    else
      @vote.destroy
      redirect_to votes_path
      return
    end
  end
  
  
  private             
  
  def vote_params
    return params.require(:vote).permit(:name, :category, :title, :creator, :publication_year, :description)
  end
end
