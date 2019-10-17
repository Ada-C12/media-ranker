class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]
  before_action :if_work_missing, only: [:show, :edit, :destroy]
  
  def index
    @works = Work.all 
  end
  
  def show ; end
  
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
      flash.now[:warning] = "A problem occurred: Could not create #{@work.category}"
      
      if @work.errors.any?
        @work.errors.each do |column, message| 
          flash.now[column.to_sym] = message
        end
      end
      
      render :new
      return
    end
  end
  
  def edit ; end
  
  def update 
    if @work.nil?
      head :not_found
      return
    end
    
    if @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:warning] = "A problem occured: Could not update #{@work.category}"
      
      if @work.errors.any?
        @work.errors.each do |column, message| 
          flash.now[column.to_sym] = message
        end
      end
      
      render :edit  
      return
    end
  end
  
  def destroy
    @work.destroy
    flash[:success] = "Successfully destroyed #{@work.category} #{@work.id}"
    redirect_to root_path
    return
  end
  
  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
  
  def find_work
    @work = Work.find_by(id: params[:id])
  end
  
  def if_work_missing
    if @work.nil?
      head :not_found
      return
    end
  end
end
