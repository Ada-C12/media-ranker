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
