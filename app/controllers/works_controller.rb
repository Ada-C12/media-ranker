class WorksController < ApplicationController
  

  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all 
  end
  
  def show
    if @work.nil?
      flash[:error] = "Could not find media"
      redirect_to works_path
      return
    end
  end
  
  def new
    @work = Work.new
  end
  
  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "Successfully created new media!"
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "Unable to create media"
      render :new
    end
  end
  
  def edit
    if @work.nil?
      flash[:error] = "Could not find media"
      redirect_to works_path
      return
    end
  end
  
  def update
    if @work.nil?
      flash[:error] = "Could not find media"
      redirect_to works_path
      return
    end
    
    if @work.update(work_params)
      redirect_to work_path
      return
    else
      flash.now[:error] = "Unable to update media"
      render :edit
      return
    end
  end
  
  def destroy
    if @work.destroy
      flash[:success] = "Successfully deleted media"
      redirect_to works_path
      return
    else
      flash[:error] = "Unable to delete media"
      redirect_to work_path
      return
    end
  end
  
  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end
  
end