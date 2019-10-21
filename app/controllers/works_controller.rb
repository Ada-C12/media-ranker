class WorksController < ApplicationController
  
  def index
    @works = Work.all
    @albums = Work.where(category: "album")
    @books = Work.where(category: "book")
    @movies = Work.where(category: "movie")
  end
  
  def show
    work_id = params[:id].to_i
    @work = Work.find_by(id: work_id)
    if @work.nil?
      redirect_to works_path
      return
    end
  end
  
  def new
    @work = Work.new
  end
  
  def create
    @work = Work.new( work_params )
    if @work.save
      redirect_to work_path(@work.id)
    else
      render new_work_path
    end
  end
  
  def vote
    current_user = User.find_by(id: session[:user_id])
    current_work = Work.find_by(id: params[:id])
    
    if current_user == nil
      flash[:warning] = "You must log in to vote"
      redirect_to works_path
      return
    end
    
    if current_user.votes.where(work_id: current_work.id).length > 0
      flash[:warning] = "You have already voted for this work."
      redirect_to works_path
      return
    end
    
    vote_params = current_work.upvote(current_user)
    
    @vote = Vote.new( vote_params )
    
    if @vote.save
      flash[:message] = "Successfully upvoted!"
      redirect_to works_path
    else
      render root_path
    end
  end
  
  def edit
    @work = Work.find_by(id: params[:id] )
    if @work.nil?
      redirect_to works_path
      return
    end
  end
  
  def update
    @work = Work.find_by(id: params[:id] )
    if @work.nil?
      head :not_found
      return
    elsif @work.update( work_params )
      redirect_to work_path(@work.id)
    else
      render :edit
    end
  end
  
  def destroy
    
    @work = Work.find_by( id: params[:id] )
    
    if @work.nil?
      redirect_to works_path
      return
    else
      @work.destroy
      flash[:message] = "Successfully deleted #{@work.title}"
      redirect_to works_path
      return
    end
  end
  
  private             
  
  def work_params
    return params.require(:work).permit(:name, :category, :title, :creator, :publication_year, :description)
  end
end
