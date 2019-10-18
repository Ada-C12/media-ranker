class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]
  before_action :if_work_missing, only: [:show, :edit, :destroy]
  
  def index
    @albums = Work.sort_works("album")
    @movies = Work.sort_works("movie")
    @books = Work.sort_works("book")
  end
  
  def show; end
  
  def new
    @work = Work.new
  end
  
  def create
    @work = Work.new(work_params) 
    if @work.save
      flash[:success] = "Successfully created #{@work.category} '#{@work.title}''."
      redirect_to work_path(@work.id)
      return
    else 
      render :new 
      return
    end
  end
  
  def edit; end
  
  def update
    if @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} '#{@work.title}''."
      redirect_to work_path(@work)
      return
    else 
      render :edit 
      return
    end
  end
  
  def destroy
    @work.destroy
    
    redirect_to works_path
    return 
  end
  
  def main
    @top_ten_albums = Work.top_ten("album")
    @top_ten_books = Work.top_ten("book")
    @top_ten_movie = Work.top_ten("movie")
    
    @spotlight = Work.best_work(Work.all)
  end
  
  def upvote
    current_user = User.find_by(id: session[:user_id])
    current_work = Work.find_by(id: params[:id])
    votes = Vote.where(work_id: current_work.id)
    prev = Rails.application.routes.recognize_path(request.referrer)
    can_vote = true
    
    if !current_user
      flash[:warning] = "You must be logged in to perform this action."
      if prev[:action] == "index"
        redirect_to works_path
      else
        redirect_to work_path(current_work)
      end
      
      return
    end
    
    votes.each do |vote|
      if vote.user_id == current_user.id
        can_vote = false
      end
    end
    
    if votes.length != 0 && !current_user
      flash[:warning] = "You must be logged in to perform this action."
      if prev[:action] == "index"
        redirect_to works_path
      else
        redirect_to work_path(current_work)
      end
      
      return
      
    elsif votes.length != 0 && can_vote == false
      flash[:warning] = "You may only vote for this media once."
      if prev[:action] == "index"
        redirect_to works_path
      else
        redirect_to work_path(current_work)
      end
      
      return
      
    end
    
    if current_user
      vote = Vote.new(user_id: current_user.id, work_id: current_work.id)
      if vote.save
        flash[:success] = "Successfully Upvoted!"
      else
        flash[:error] = "Unable to upvote."
      end
    else
      flash[:warning] = "You must be logged in to perform this action."
    end
    
    if prev[:action] == "index"
      redirect_to works_path
    else
      redirect_to work_path(current_work)
    end
    
  end
  
  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
  
  def find_work
    @work = Work.find_by(id: params[:id])
  end
  
  
  def if_work_missing
    if @work.nil?
      flash[:error] = "That work was not found."
      redirect_to root_path
      return
    end
  end
  
end
