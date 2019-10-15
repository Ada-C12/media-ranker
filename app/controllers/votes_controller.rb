class VotesController < ApplicationController
  def show
  end
  
  def create
    date = Date.today
  end 
  
  def edit 
  end
  
  def update
  end
  
  def destroy
  end
  
  private 
  
  def vote_params
    return params.require(:vote, :user_id, :media_id, :date)
  end 
end
