class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]
  
  def index
    @all_movies = Work.ranked_all_in(category: "movie")
    @all_albums = Work.ranked_all_in(category: "album")
    @all_books = Work.ranked_all_in(category: "book")
  end
  
  def new
    @work = Work.new
  end
  
  def create
    @work = Work.new(form_params)
    if @work.save
      flash[:success] = "Successfully created #{@work.category}: #{@work.title}"
      redirect_to work_path(id: @work.id)
      return
    else
      flash.now[:error] = "Unsuccessful save:"
      flash.now[:error_msgs] = list_error_messages(@work)
      render action: "new"
      return
    end
  end
  
  def show
    # @work via before_action
    unless @work
      flash[:error] = "LOL that piece of media got deleted. Womp womp!"
      redirect_to nope_path
      return
    end
  end
  
  def edit
    # @work via before_action
  end
  
  def update
    # @work via before_action
    if @work.update(form_params)
      flash[:success] = "Successfully updated #{@work.title}"
      redirect_to work_path(id: @work.id)
      return
    else
      flash.now[:error] = "Failed to update #{@work.title}"
      render action: "edit"
      return
    end
  end
  
  def destroy
    # @work via before_action
    if @work.destroy
      flash[:success] = "Successfully deleted #{@work.title}"
      redirect_to root_path
      return
    else
      flash[:error] = "Deletion failed for some reason"
      render
      return
    end
  end
  
  private
  def form_params
    return params.require(:work).permit(:category, :title, :creator, :published_year, :description)
  end
  
  def find_work
    @work = Work.find_by(id: params[:id].to_i)
  end
  
end
