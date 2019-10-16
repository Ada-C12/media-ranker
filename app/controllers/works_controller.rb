class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit]

  def index
    @books = Work.works_by_category("book")
    @movies = Work.works_by_category("movie")
    @albums = Work.works_by_category("album")
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

  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end
end
