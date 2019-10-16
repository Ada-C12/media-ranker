class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]
  before_action :if_work_missing, only: [:edit, :update, :destroy]
  
  def index
    @works = Work.all
    @categories = ["album", "book", "movie"]
  end
  
  def show
    if @work.nil?
      redirect_to works_path
      return
    end
  end
  
  def new
    @work = Work.new
  end
  
  def create
    if params[:work].nil?
      redirect_to new_work_path
      return
    end
    
    @work = Work.new(work_params)
    
    if @work.save
      flash[:success] = "Successfully created #{@work.category} #{@work.id}."
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:failure] = "A problem occurred: Could not create #{@work.category}."
      render :new
      return
    end
  end
  
  def edit; end
  
  def update
    if @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}."
      redirect_to work_path
      return
    else
      flash.now[:failure] = "#{@work.category.capitalize} failed to update."
      render :edit
      return
    end
  end
  
  def destroy
    @work.destroy
    redirect_to works_path
    return
  end
  
  private
  
  def work_params
    params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
  
  def find_work
    @work = Work.find_by(id: params[:id])
  end
  
  def if_work_missing
    if @work.nil?
      flash.now[:failure] = "#{@work.category.capitalize} not found."
      redirect_to works_path
      return
    end
  end
end
