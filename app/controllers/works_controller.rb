class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update]
  
  def index
    @works = Work.all
  end
  
  def show
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
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:error] = "A problem ocurred: Could not create #{@work.category}"
      render new_work_path
      return
    end
  end
  
  def edit
  end
  
  def update
    if @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
      return
    else
      flash[:error] = "A problem occurred: Could not update #{@work.category}"
      render new_work_path
      return
    end
  end
  
  def destroy
    current_work = Work.find_by(id: params[:id])
    
    if current_work.nil?
      redirect_to works_path
      return
    else
      current_work.destroy
      flash[:success] = "Successfully destroyed #{current_work.category} #{current_work.id}"
      redirect_to root_path
      return
    end
  end
  
  private
  
  def find_work
    @work = Work.find_by(id: params[:id])
  end
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
  
end
