class WorksController < ApplicationController
  def index
    @works = Work.all 
  end
  
  def show
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      # Might not be the correct redirect??
      # The page you were looking for doesn't exist. You may have mistyped the address or the page may have moved.
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
    
    if @work.nil?
      head :not_found
      return
    end
    
    if @work.update(work_params)
      redirect_to work_path(@work.id)  
      return
    else  
      render :edit  
      return
    end
  end
  
  def destroy
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      head :not_found
      return
    end
    
    @work.destroy
    
    redirect_to works_path
    return
  end
  
  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
