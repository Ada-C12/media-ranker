class WorksController < ApplicationController
   def index
    @works = Work.all.order(:title) 
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
    puts work_params
    if @work.save
      flash[:success] = "Work added successfully"
      redirect_to work_path(@work) 
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
    redirect_to works_path
    return
  end
  
  private
  
  def work_params
    return params.require(:work).permit(:title, :creator, :description, :publication_year, :category)

  end
end 


