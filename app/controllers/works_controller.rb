class WorksController < ApplicationController
  
  
  def index
    @works = Work.all
    @books = Work.where(category: "book")
    @movies = Work.where(category: "movie")
    @albums = Work.where(category: "album")
  end
  
  def show
    @work = Work.find_by(id: params[:id])
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
  
  def edit
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      redirect_to work_path
    end
  end
  
  def update
    @work = Work.find_by(id: params[:id])
    if@work.nil?
      flash[:error] = "Media could not be found"
      redirect_to works_path
      return
    end
    
    if @work.update( work_params )
      redirect_to work_path
      return
    else
      flash.now[:error] = "Unable to complete update"
      render :edit
      return
    end
  end
  
  def destroy
    
    target_work = Work.find_by( id: params[:id] )
    
    if target_work.nil? 
      flash[:error] = "That work does not exist" 
      redirect_to root_path
    else
      target_work.destroy
      redirect_to root_path
      return
    end
  end
  
  
  def work_params
    
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
    
  end
end