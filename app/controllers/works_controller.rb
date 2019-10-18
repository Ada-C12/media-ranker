class WorksController < ApplicationController

  # Order matters here
  before_action :find_work, only: [:show, :edit, :update, :destroy]
  before_action :if_work_missing, only: [:show, :edit, :destroy]

  def index
    @movies = Work.where(category: "movie")
    @albums= Work.where(category: "album")
    @books = Work.where(category: "book")


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
      flash.now[:failure] = "Work did not add successfully"
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
      @work.destroy
      redirect_to works_path
      return 
    # end 
  end

  def upvote
    # Every time a user votes, I need to append another row onto the votes table. 
    # But first, check for the work id and the user id in the votes table. 
    user = User.find_by(id: session[:id])
    work = Work.find_by(id: params[:id])

    result = Vote.user_already_vote?(work, user)

    if result == true 
      flash[:success] = "Successfully upvoted!"
      redirect_to works_path
    elsif result == false
      flash[:error] = "Could not upvote. The user has already voted for this work."
      redirect_to works_path
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
