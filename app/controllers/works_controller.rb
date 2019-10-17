class WorksController < ApplicationController
  def index
    @works = Work.all
  end
  
  def show
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      flash[:error] = "Could not find work with id: #{params[:id]}"
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
      redirect_to work_path(@work)
      return
    else
      render :new
      return
    end
  end
  
  def edit
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      redirect_to works_path
      return
    end 
  end
  
  def update
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      redirect_to works_path
      return
    end 
    
    @work.update(work_params)
    
    redirect_to work_path(@work)
    return
  end
  
  def destroy
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      redirect_to works_path
      return
    end 
    
    @work.destroy
    redirect_to works_path
    return
  end

  def upvote
    if session[:user_id].nil?
      flash[:warning] = "Please log in to vote"
      render :new
      return
    else
      Vote.create(user_id: session[:user_id], work_id: params[:id])
      redirect_to root_path
      return
    end
  end
  
  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
  
end
