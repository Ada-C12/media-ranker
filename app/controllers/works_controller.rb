class WorksController < ApplicationController
  def media_spotlight
    @work = Work.all.sample
    @movies = Work.where(category: "movie").sample(10)
    @books = Work.where(category: "book").sample(10)
    @albums = Work.where(category: "album").sample(10)
  end

  def index
    @works = Work.all
  end

  def show
    work_id = params[:id]
    
    @work = Work.find_by(id: work_id)
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
      render new_work_path
      return
    end
  end
  
  def edit
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      redirect_to root_path
      return
    end
  end
  
  def update
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
      return
    else
      render :edit
      return
    end
  end
  
  def destroy
    work = Work.find_by(id: params[:id])
    
    if work.nil?
      redirect_to works_path
      return
    else
      work.destroy
      flash[:success] = "Successfully destroyed #{work.category} #{work.id}"
      redirect_to root_path
      return
    end
  end

  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
