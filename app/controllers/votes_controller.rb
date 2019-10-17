class VotesController < ApplicationController
  def new
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
    end
    
    def create
    end
  end
  