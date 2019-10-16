class WorksController < ApplicationController
  
  def index
    @works = Work.all
    @albums = Work.top_ten_category("album")
    @books = Work.top_ten_category("book")
    @movies = Work.top_ten_category("movie")
  end
  
  def show
    work_id = params[:id].to_i
    @work = Work.find_by(id:work_id)
    if @work.nil?
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
      redirect_to work_path(@work.id)
    else
      render new_work_path      
    end
  end
  
  def edit
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      redirect_to works_path
      return
    end
  end
  
  def update
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      redirect_to works_path
      return
    end
    if @work.update(work_params)
      redirect_to work_path(@work.id)
    else
      render new_work_path
    end
  end
  
  def destroy
    selected_work = Work.find_by(id: params[:id])
    if selected_work.nil?
      redirect_to works_path
      return
    else
      selected_work.destroy
      redirect_to works_path
      return
    end
  end
  
  
  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
