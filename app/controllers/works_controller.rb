class WorksController < ApplicationController
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
      flash[:sucess] = "Work added successfully"
      redirect_to root_path
      return
    else
      flash.now[:failure] = "Work did not add successfully"
      render :new 
      return 
    end
  end 

  def show
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
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

    if @work.update(work_params)
      redirect_to works_path
      return
    else
      render :update
      return
    end 
  end 

  def destroy
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      redirect_to works_path
      return
    elsif @work.destroy
      redirect_to works_path
      return 
    end 
  end

  private
  
  def work_params
    params.require(:work).permit(:category, :title, :creator, :publication_year, :description )
  end
end
