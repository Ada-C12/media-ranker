class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]
  
  def index
    @works = Work.all
  end

  def show
    if @work.nil?
      flash[:error] = "Work doesn't exist"
      redirect_to root_path
      return
    end
  end

  def new
    @work = Work.new
  end

  def edit
    if @work.nil?
      flash[:error] = "Can't edit work that doesn't exist"
      redirect_to works_path
      return
    end
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = 'Work was successfully created.'
      redirect_to @work
    else
      flash[:error] = 'Oops! Something went wrong.'
      render :new
    end
  end

  def update
    if @work.nil?
      head :not_found
      return
    end

    if @work.update(work_params)
      flash[:success] = 'Work was successfully updated.'
      redirect_to @work
    else
      flash[:error] = 'Oops! Something went wrong.'
      render :edit
    end
  end

  def destroy
    if @work.nil?
      head :not_found
      return
    end
    
    if @work.destroy
      flash[:success] = 'Work was successfully destroyed.'
      redirect_to works_path
    else
      flash[:error] = 'Oops! Something went wrong.'
      redirect_to works_path
    end
  end

  private

  def find_work
    @work = Work.find_by(id: params[:id])
  end 
  
  def work_params
    params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end 
end
