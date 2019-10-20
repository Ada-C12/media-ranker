class WorksController < ApplicationController
  
  def index
    @works = Work.all
  end
  
  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    
    if @work.nil?
      redirect_to root_path
    end
  end
  
  def new
    @work = Work.new
  end
  
  def create
    @work = Work.new(category: params[:work][:category], title: params[:work][:title], creator: params[:work][:creator], publication_year: params[:work][:publication_year], description: params[:work][:description])
    if @work.save 
      flash[:success] = "Your work has been added."
      redirect_to root_path
      return
    else 
      flash.now[:warning] = "Your work could not be saved because #{@work.errors.full_messages}"
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
      flash[:success] = "You updated a work successfully!"
      redirect_to root_path
    else 
      flash[:warning] = "This work did not update because #{@work.errors.messages}"
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
    params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
  
end
