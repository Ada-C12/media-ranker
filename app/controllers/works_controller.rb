class WorksController < ApplicationController

  before_action :find_work, only: [:show, :edit, :update]

  def index
    @works = Work.all
    @movies = Work.category_list("movie")
    @books = Work.category_list("book")
    @albums = Work.category_list("album")
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
    @work = Work.new( work_params )
    if @work.save
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:warning] = "A problem occurred: Could not create #{@work.category}"
      render :new
      return
    end
  end

  def edit
    
  end

  def update
    if @work.nil?
      redirect_to root_path
      return
    elsif @work.update( work_params )
      redirect_to work_path(@work.id)
      return
    else
      render :edit
      return
    end
  end

  def destroy
    the_correct_work = Work.find_by( id: params[:id] )
    if the_correct_work.nil?
      redirect_to root_path
      return
    else
      the_correct_work.destroy
      flash[:success] = "Your work " + the_correct_work.title + " was successfully deleted!"
      redirect_to root_path
      return
    end
  end

  private

  def find_work
    @work = Work.find_by(id: params[:id])
  end

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
