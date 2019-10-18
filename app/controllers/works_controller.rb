class WorksController < ApplicationController
  
  def new
    @work = Work.new
  end
  
  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to root_path
    else
      render new_work_path
    end
  end
  
  def index
    @works = Work.all
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def work_params
    params.require(:work).permit(:name, :description, :creator, :category, :publication_year)
  end
  
end
