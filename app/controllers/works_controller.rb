class WorksController < ApplicationController
  def index
    @works = Work.all
    @categories = ["album", "book", "movie"]
  end
  
  def show
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      redirect_to works_path
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
    elsif @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}."
      redirect_to work_path
      return
    else
      flash.now[:failure] = "#{@work.category.capitalize} failed to update."
      render :edit
      return
    end
  end
  
  def destroy
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      head :not_found
      return
    end
    
    @work.destroy
    
    redirect_to works_path
    return
  end
  
  private
  
  def work_params
    params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
