class VotesController < ApplicationController
  def index
  end
  
  def show
  end
  
  def new
    @vote = Vote.new
  end
  
  def create
    @vote = Vote.new(vote_params)
    
    if @vote.save
      redirect_to vote_path(@vote.id)
      return
    else 
      render :new 
      return
    end
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def vote_params
    return params.require(:vote).permit(:vote_id, :user_id)
  end
end
