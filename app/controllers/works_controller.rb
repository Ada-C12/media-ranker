class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]
  before_action :if_work_missing, only: [:show, :edit, :destroy]
  
  def index
    @albums = Work.where(category: "album")
    @movies = Work.where(category: "movie")
    @books = Work.where(category: "book")
  end
  
  def show; end
  
  def new
    @work = Work.new
  end
  
  def create
    @work = Work.new(work_params) 
    if @work.save
      redirect_to work_path(@work.id)
      return
    else 
      render :new 
      return
    end
  end
  
  def edit; end
  
  def update
    if @work.update(work_params)
      redirect_to work_path(@work)
      return
    else 
      render :edit 
      return
    end
  end
  
  def destroy
    @work.destroy
    
    redirect_to works_path
    return 
  end
  
  def main
    @top_ten_albums = Work.top_ten("album")
    @top_ten_books = Work.top_ten("book")
    @top_ten_movie = Work.top_ten("movie")
    
    @spotlight = Work.best_work(Work.all)
  end
  
  def upvote
    current_user = User.find_by(id: session[:user_id])
    work = Work.find_by(id: params[:id])
    if current_user
      vote = Vote.new(user_id: current_user.id, work_id: work.id)
      if vote.save
        flash[:success] = "Successfully Upvoted!"
      else
        flash[:error] = "Unable to upvote."
      end
    else
      flash[:error] = "You must be logged in to perform this action."
    end
    
    redirect_to work_path(work)
  end
  
  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
  
  def find_work
    @work = Work.find_by(id: params[:id])
  end
  
  
  def if_work_missing
    if @work.nil?
      flash[:error] = "Work #{work.title} was not found."
      redirect_to root_path
      return
    end
  end
  
end
