class WorksController < ApplicationController
  def index
    @works = Work.all
  end
  
  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    
    if @work.nil?
      flash[:error] = "Could not find work with id: #{work_id}"
      redirect_to works_path
      return
    end
  end
  
  def new
    @work = Work.new
  end
  
  def create
    @work = Work.new
    
    if @work.save
      redirect_to work_path(@work)
      return
    else
      render :new
      return
    end
  end
  
  def edit
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      redirect_to works_path
      return
    end 
  end
  
  def update
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      redirect_to works_path
      return
    end 
    
    @work.update(work_params)
    
    redirect_to work_path(@work)
    return
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
  
  
  private
  
  # def work_params
  #   return params.require(:work).permit(:category, :title)
  # end
  
end
