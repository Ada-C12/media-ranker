class WorksController < ApplicationController
  def index
    @all_albums = Work.all_albums
    @all_books = Work.all_books
    @all_movies = Work.all_movies
  end
  
  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    
    if @work.nil?
      head :not_found
      return
    end
  end
  
  def new
  end
  
  def create
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
end
