class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]
  before_action :missing_work, only: [:show, :edit]
  
  def index
    @all_albums = Work.all_albums
    @all_books = Work.all_books
    @all_movies = Work.all_movies
  end
  
  def show ; end
  
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
  
  def edit ; end
  
  def update
    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      redirect_to work_path(@work.id)
      return
    else 
      render :edit
      return
    end
  end
  
  def destroy
    if @work.nil?
      head :not_found
      return
    elsif @work.destroy
      redirect_to works_path
      return
    else
      render :show
    end
  end
  
  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
  
  def find_work
    @work = Work.find_by_id(params[:id])
  end
  
  def missing_work
    if @work.nil?
      head :not_found
      return
    end
  end
end
