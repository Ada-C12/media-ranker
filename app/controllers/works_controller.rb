class WorksController < ApplicationController
  
  # before_action :find_book, only: [:show, :edit, :update, :destroy]
  #before_action :if _work_missing, only[:show, :edit, :destroy]
  def index
    @works = Work.all.order(:title) 
    @all_movies = Work.where(category: "movie")
    @all_books = Work.where(category: "book")
    @all_albums = Work.where(category: "album")
    #  @works = Work.all
    @top_movies = Work.top_ten("movie") 
    @top_books = Work.top_ten("book") 
    @top_albums = Work.top_ten("album") 
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
    @work = Work.new
  end
  
  def create
    @work = Work.new(work_params) 
    if @work.save 
      flash[:success] = "work added successfully"
      redirect_to root_path 
      return
    else 
      flash.now[:failure] = "Work failed to save"
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
    if @work.nil?
      redirect_to root_path
      return
    end
    if @work.update(work_params)
      redirect_to root_path 
      return
    else 
      render :edit 
      return
    end
  end
  
  def destroy
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    
    if @work.nil?
      head :not_found
      return
    end
    
    @work.destroy
    deleted = Work.find_by(id: work_id)
    if !deleted
      flash[:success] = "Successfully deleted work"
    else
      flash[:warning] = "Can Not Delete"
    end
    redirect_to root_path
    return
  end
  
  private
  
  def work_params
    return params.require(:work).permit(:title, :creator, :description, :publication_year, :category)
  end

  # def find_work
  #   @work = Work.find_by_id(params[:id])
  # end
  # def if work_missing
  #if @work.nil?
  # flash[:error] ="work with id#{params[:id] was not find."
  #   redirect_to root_path
  #   return
  # end
  # end
end 


