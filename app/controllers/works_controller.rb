class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update]

  def index
    @works = Work.all
    @albums = Work.sort_by_category("album")
    @books = Work.sort_by_category("book")
    @movies = Work.sort_by_category("movie")
  end
  
  def show
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
    if @work.nil?
      redirect_to works_path
      return
    end
  end
  
  def update
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
  
  def upvote
    work = Work.find_by(id: params[:id])
    found_user = User.find_by(id: session[:user_id])
    if found_user
      Vote.create(work: work, user: found_user)
      return redirect_to works_path
    else
      flash[:message] = "Cannot vote without logging in"
      return redirect_to works_path
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
