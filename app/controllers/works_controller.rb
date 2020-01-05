class WorksController < ApplicationController
  def index 
    @works = Work.all
    @movies = Work.sort_by_category("movie")
    @books = Work.sort_by_category("book")
    @albums = Work.sort_by_category("album")
  end
  
  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    
    if @work.nil?
      flash[:warning] = "Work invalid."
      redirect_to works_path
      return
    end   
  end
  
  def new
    @work = Work.new
  end
  
  def edit
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      flash[:warning] = "Can't edit, work invalid."
      redirect_to works_path
      return
    end
  end
  
  def create
    @work = Work.new(work_params) 
    
    if @work.save
      flash[:success] = "Work successfully created."
      redirect_to work_path(@work.id)
      return
    else
      flash[:warning] = "Can't create work."
      redirect_to works_path
      return
    end
  end 
  
  def update
    @work= Work.find_by(id: params[:id])
    
    if @work.update(work_params)
      flash[:success] = "Work successfully updated."
      redirect_to work_path(@work.id)
      return
    else
      flash[:warning] = "Can't update work."
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
    
    if @work.destroy
      flash[:success] = "Work successfully deleted."
      redirect_to works_path
      return
    else
      flash[:warning] = "Can't delete work."
      redirect_to works_path
    end 
  end
  
  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :description, :publication_year)
  end
end
