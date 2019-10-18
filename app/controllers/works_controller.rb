class WorksController < ApplicationController
  def index
    @movies = Work.where(category: "movie")
    @albums = Work.where(category: "album")
    @books = Work.where(category: "book")
  end 

  def new 
    @work = Work.new
  end 

  def show
    work_id = params[:id].to_i
    @work = Work.find_by(id:params[:id])
    if @work.nil?
      head :not_found 
    end
  end 

  def create
    @work = Work.new(work_params)
    
    if @work.save
      redirect_to work_path(@work.id)
      return
    else
      render new_work_path
    end
  end 

  def edit
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      head :not_found
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      redirect_to work_path(@work.id)
      return
    else
      head :not_found
    end
  end 

  def destroy
    selected_work = Work.find_by(id: params[:id])
    
    if selected_work.nil?
      head :not_found
      return
    else
      selected_work.destroy
      redirect_to works_path
    end
  end 

  def upvote
    if session[:user_id] == nil
      #FLASH NOT WORKING
      flash[:message] = "Must be logged in to upvote."
      return
    else 
      @work = Work.find_by(id: params[:id])

      @work.votes.create(work_id: @work.id, user_id:session[:user_id])
      flash[:message] = "Upvote done!"
      redirect_to works_path
    end 
  end 


  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
