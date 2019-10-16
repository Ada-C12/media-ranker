class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update]
  
  def index
    @books = Work.works_sorted_by_category("book")
    @movies = Work.works_sorted_by_category("movie")
    @albums = Work.works_sorted_by_category("album")
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
      flash[:success] = "New work created!"
      redirect_to work_path(Work.find_by(title: @work.title, category: @work.category))
      return
    end
    
    flash.now[:error] = "Failed to create work!"
    render :new
  end
  
  def update
    if @work
      if @work.update(work_params)
        flash[:success] = @work.title + " updated successfully!"
        redirect_to work_path(@work.id)
        return
      else
        flash.now[:error] = "Invalid input! Failed to update work"
        render :edit
        return
      end
    end
    head :not_found
    return
  end
  
  def destroy
    existing_work = Work.find_by(id: params[:id])
    if existing_work
      flash[:success] = existing_work.title + " has been deleted!"
      existing_work.destroy
    end
    redirect_to works_path
    return
  end

  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
  
  def find_work
    @work = Work.find_by(id: params[:id])
  end
end
