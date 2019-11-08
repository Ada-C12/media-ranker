class WorksController < ApplicationController
  
  def index
    @books = Work.where(category: "book")
    @albums = Work.where(category: "album")
    @movies = Work.where(category: "movie")
  end
  
  def new
    @work = Work.new
  end
  
  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    
    if @work.nil?
      head :not_found
      return
    end
  end
  
  def create
    @work = Work.create(work_params)
    if @work.save
      flash[:success] = "Work saved successfully #{@work.id}"
      redirect_to works_path
      return
    else
      flash.now[:failure] = "Work failed to save"
      render :new
      return
    end
  end
  
  def edit
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    
    if @work.nil?
      head :not_found
      return
    end
  end
  
  def update
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    
    if @work.nil?
      head :not_found
      return
    end
    
    if @work.update(work_params)
      redirect_to work_path
      return
    else
      render :edit
      return
    end
  end
  
  def destroy
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    flash[:success] = "Work destroyed successfully"
    if @work.nil?
      head :not_found
      return
    end
    
    @work.destroy
    
    redirect_to root_path
    return
  end
  
  # def upvote
  #   @work = Work.find(params[:id])
  #   @work.votes.create
  #   redirect_to work_path
  # end
  
  
  # Added make and model to permit below
  
  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
  
  # def find_work
  #   @work = Work.find_by(id: work_id)
  # end
end


