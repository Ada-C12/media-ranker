class WorksController < ApplicationController
  def index
    @albums = Work.where(category: "album")
    @movies = Work.where(category: "movie")
    @books = Work.where(category: "book")
  end
  
  def show
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      redirect_to root_path
      return
    end
  end
  
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
  
  def edit
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      head :not_found
      return
    end
  end
  
  def update
    @work = Work.find_by(id: params[:id])
    if @work.update(work_params)
      redirect_to root_path
      return
    else 
      render :edit 
      return
    end
  end
  
  def destroy
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      redirect_to works_path
      return
    end
    
    @work.destroy
    
    redirect_to works_path
    return 
  end
  
  def main
    @top_ten_albums = Work.top_ten("album")
    @top_ten_books = Work.top_ten("book")
    @top_ten_movie = Work.top_ten("movie")
  end
  
  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
  
end
