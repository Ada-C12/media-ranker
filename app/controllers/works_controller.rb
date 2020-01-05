class WorksController < ApplicationController
  
  before_action :current_user
  before_action :find_work, only: [:show, :edit, :update, :destroy]
  before_action :if_work_missing, only: [:edit, :update, :show]
  

  def index
    @works = Work.all
    @movies = Work.all_movies
    @albums = Work.all_albums
    @books = Work.all_books
  end
  
  def show ; end
  
  def new
    @work = Work.new
  end
  
  def create
    work = Work.new(work_params)
    work.save
    flash[:success] = "Work added successfully."
    redirect_to work_path(work)
    return
  end

  def edit ; end

  def update
    @work.update_attributes(work_params)
    
    flash[:success] = "Successfully updated the #{@work.category} entitled #{@work.title}."
    redirect_to work_path(@work)
    return
  end

  def destroy
    if @work.nil?
      flash[:error] = "Could not find work with id: #{params[:id]}"
      redirect_to root_path
      return
    end
    
    @work.destroy
    flash[:success] = "Successfully destroyed the #{@work.category} entitled #{@work.title}."
    redirect_to root_path
    return
  end

  private
    def work_params
      return params.require(:work).permit(:title, :description, :creator, :publication_year, :category)
    end

    def find_work
      @work = Work.find_by(id: params[:id])
      return @work
    end

    def if_work_missing
      if @work.nil?
        flash[:failure] = "Media edit failed to save"
        redirect_to works_path
        return
      end
    end
  end

