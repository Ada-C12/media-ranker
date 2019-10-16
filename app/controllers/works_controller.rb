class WorksController < ApplicationController
  
  before_action :find_work, only: [:show, :edit, :update, :destroy]
  
  def index
    @works = Work.all
    @categories = ["movie", "book", "album"]
  end
  
  def show; end
  
  def new
    @work = Work.new
  end
  
  def create 
    work = Work.new(work_params)
    if work.save
      redirect_to work_path(work.id)
    else
      flash.now[:error] = "A problem occurred: Could not create"
      render :new
    end
  end
  
  def edit; end
  
  def update
    if @work.update(work_params)
      redirect_to work_path
    else
      @flash.now[:error] = "A problem occurred: Could not update album"
      render :edit
    end
  end
  
  def destroy
    @work.destroy
    flash[:success] = "Successfully deleted!"
    redirect_to root_path
  end
  
  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description )
  end
  
  def find_work
    @work = Work.find(params[:id])
  end
  
end
