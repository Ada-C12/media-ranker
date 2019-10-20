class WorksController < ApplicationController

  # Order matters here
  before_action :find_work, only: [:show, :edit, :update, :destroy]
  before_action :if_work_missing, only: [:show, :edit, :destroy]

  def index
    @movies = Work.sort_by_category("movie")
    @albums = Work.sort_by_category("album")
    @books = Work.sort_by_category("book")

    # @movies = Work.where(category: "movie")
    # @albums= Work.where(category: "album")
    # @books = Work.where(category: "book")
  end

  def new
    @work = Work.new
  end 

  def create
    @work = Work.new(work_params)
    
    if @work.save
      flash[:success] = "Work added successfully"
      redirect_to root_path
      return
    else
      @work.errors.each do |column, message|
        flash.now[:failure] = "Could not create new work. #{column.capitalize} #{message}"
      end
      render :new 
      return 
    end
  end 

  def show
    # @work = Work.find_by(id: params[:id])

    # if @work.nil?
    #   head :not_found
    #   return
    # end 
  end 

  def edit
    
    # @work = Work.find_by(id: params[:id])

    # if @work.nil?
    #   redirect_to works_path
    #   return
    # end 
  end 

  def update
    # @work = Work.find_by(id: params[:id])

    # if @work.nil?
    #   redirect_to works_path
    #   return
    # end 
    if @work.update(work_params)
      redirect_to works_path
      return
    else
      render :update
      return
    end 
  end 

  def destroy
    # @work = Work.find_by(id: params[:id])
    
    # if @work.nil?
    #   redirect_to works_path
    #   return
    # elsif 
      
      @work.votes.destroy_all
      # don't want to keep votes with a foreign key that doesn't exist anymore
      @work.destroy
      redirect_to works_path
      return 
    # end 
  end

  def upvote

    if session[:id].nil?
      flash[:error] = "A problem occured: You must be logged in to do that."
      redirect_to works_path
      return 
    end 

    user = User.find_by(id: session[:id])
    work = Work.find_by(id: params[:id])

    result = Vote.user_already_vote?(work, user)

    if result == true 
      flash[:success] = "Successfully upvoted!"
      redirect_to works_path
      return
    elsif result == false
      flash[:error] = "Could not upvote. The user has already voted for this work."
      redirect_to works_path
      return
    end 
  end 

  private
  
  #strong params
  def work_params
    params.require(:work).permit(:category, :title, :creator, :publication_year, :description )
  end

  # controller filter used to dry up code
  
  def find_work
    @work = Work.find_by(id: params[:id])
  end 

  # controller filter used to dry up code
  
  def if_work_missing
    if @work.nil?
      flash[:error] = "Work with id #{params[:id]} was not found"
      redirect_to works_path
      return
    end 
  end
end
