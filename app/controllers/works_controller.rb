class WorksController < ApplicationController
  
  
  def index
    @works = Work.all
    @top_ten_movies = Work.highest_ten("movie")
    @top_ten_books = Work.highest_ten("book")
    @top_ten_albums = Work.highest_ten("album")
  end
  
  def show
    @work = Work.where(title: params[:title])
    if @work.nil?
      flash[:error] = "That work does not exist"
      redirect_to new_work_path
    end
  end
  
  def new
    @work = Work.new
  end
  
  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to work_path(@work.title)
    else
      flash[:error] = "Unable to create new work"
      render new_work_path
    end
  end
  
  # def index
  #   work_title = params[:title]
  
  #   if work_title.nil?
  #     redirect_to root_path
  #   else
  
  #   end
  
  
  
  
  
  
  
  
  def work_params
    
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
    
  end
end