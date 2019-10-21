class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update]
  
  def index
    @books = Work.works_sorted_by_category("book")
    @movies = Work.works_sorted_by_category("movie")
    @albums = Work.works_sorted_by_category("album")
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
      redirect_to work_path(Work.find_by(title: @work.title, category: @work.category))
      return
    end
    
    flash.now[:error] = "A problem occurred: Could not create #{@work.category}"
    render :new
  end
  
  def update
    if @work
      if @work.update(work_params)
        flash[:success] = @work.title + " updated successfully!"
        redirect_to work_path(@work.id)
        return
      else
        flash.now[:error] = "Invalid input! Failed to update work"
        render :edit
        return
      end
    end
    head :not_found
    return
  end
  
  def destroy
    existing_work = Work.find_by(id: params[:id])
    if existing_work
      flash[:success] = existing_work.title + " has been deleted!"
      existing_work.destroy
    end
    redirect_to root_path
    return
  end
  
  def upvote
    @work = Work.find_by(id: params[:id])
    if !@work
      head :not_found
      return
    end

    if session[:user_id]
      @vote = Vote.create_vote(user_id:session[:user_id], work_id: @work.id)
      if @vote.save
        flash[:success] = "Successfully upvoted!"
      else
        
        flash[:error] = "A problem occurred: Could not upvote"
      end
    else
      flash[:error] = "A problem occurred: You must log in to do that"
    end
    
    redirect_back(fallback_location: :back)
  end

  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
  
  def find_work
    @work = Work.find_by(id: params[:id])
  end
end
