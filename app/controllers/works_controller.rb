class WorksController < ApplicationController

  before_action :find_work, only: [:show, :edit, :update]

  def media_spotlight
    @work = Work.most_votes

    @movies = Work.top_ten("movie")
    @books = Work.top_ten("book")
    @albums = Work.top_ten("album")
  end

  def index
    @works = Work.all

    @movies = Work.sort_by_votes(Work.where(category: "movie"))
    @books = Work.sort_by_votes(Work.where(category: "book"))
    @albums = Work.sort_by_votes(Work.where(category: "album"))
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
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:error] = "A problem occurred: Could not create #{@work.category}"
      render new_work_path
      return
    end
  end
  
  def edit
    if @work.nil?
      redirect_to root_path
      return
    end
  end
  
  def update
    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:error] = "A problem occurred: Could not update #{@work.category}"
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
      work.votes.destroy_all
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

  def find_work
    @work = Work.find_by(id: params[:id])
  end
end
