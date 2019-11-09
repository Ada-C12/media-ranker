class VotesController < ApplicationController

  def index 
    @votes = Vote.all
  end

  def new
    @work = Work.new
  end

  def create
    @vote = Vote.new(vote_params) 
    if @vote.save 
      redirect_to @vote.work 
  end
end

def edit
    @vote = Vote.find_by(id: params[:id])
    if @vote.nil?
      head :not_found
      return
    end
  end

  def show
    vote_id = params[:id]
    @vote = Vote.find_by(id: work_id)
    
    if @vote.nil?
      head :not_found
      return
    end     
  end

  def update
    @vote = Vote.find_by(id: params[:id])
    if @vote.nil?
      redirect_to root_path
      return
    end
    if @vote.update(work_params)
      redirect_to works_path 
      return
    else 
      render :edit 
      return
    end
  end
  

  def destroy
    vote_id = params[:id]
    @vote = Vote.find_by(id: work_id)
    
    if @vote.nil?
      head :not_found
      return
    end
  end

    private
    def vote_params
    return params.require(:vote).permit(:work, :user_id)

    end
end