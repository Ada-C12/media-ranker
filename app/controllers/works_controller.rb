class WorksController < ApplicationController
  
  def index
    @works = Work.all
  end
  
  def show
    work_id = params[:id]
    @work_item = Work.find_by(id: work_id)
  end
  
  def new
    @work = Work.new
  end
  
  def create
    @work = Work.new(category: params[:work][:category], title: params[:work][:title], creator: params[:work][:creator], publication_year: params[:work][:publication_year], description: params[:work][:description])
    if @work.save 
      redirect_to root_path
      return
    else 
      render :new
      return
    end
  end
  
  def edit 
    @work = Work.find_by(id:params[:id])
    
    if @work.nil?
      redirect_to root_path
      return
    end
  end
  
  def update 
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      redirect_to root_path
    end
    
    if @work.update(work_params)
      redirect_to root_path
    else 
      redirect_to edit_work_path 
      return 
    end
  end
  
  def destroy
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    
    if @work.nil?
      redirect_to root_path
      return
    elsif @work.destroy 
      redirect_to root_path
      return
    end
  end
  
  private 
  def work_params
    params.require(:category, :title, :creator, :publication_year).permit(:description)
    
  end
  