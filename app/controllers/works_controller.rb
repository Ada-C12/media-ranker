class WorksController < ApplicationController
  def index
    @albums = Work.where(category: "album")
    @books = Work.where(category: "book")
    @movies = Work.where(category: "movies")
  end
  
  def main
    @spotlight = Work.spotlight
    @top_movies = Work.top_ten "movie"
    @top_books = Work.top_ten "book"
    @top_albums = Work.top_ten "album"
  end

  def show
    @work = Work.find_by(id: params[:id])
  end

  def new
    @work = Work.new
  end

  def create
    id = Work.create(work_params)&.id
    redirect_to work_path(id)
  end

  def destroy
    Work.find_by(id: params[:id]).destroy
    redirect_to works_path
  end

  def edit
    @work = Work.find_by(id: params[:id])
  end

  private
  def work_params
    params.require(:work).permit(:category, :title, :creator, :published, :description)
  end
end
