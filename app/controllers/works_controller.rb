class WorksController < ApplicationController
  def index
    @works = Work.all
    @user = User.find(session[:user_id]) rescue nil
  end
  
  def show
    @work = Work.find_by(id: params[:id])
    
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
      puts "successfully saved"
      redirect_to work_path(@work.id)
      return
    else
      puts "failed to save"
      render :new
      return
    end
  end
  
  def edit
    puts "here" * 10
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      head :not_found
      return
    end
    puts @work
  end
  
  def update
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      head :not_found
      return
    end
    puts work_params
    
    if @work.update(work_params)
      redirect_to work_path(@work.id)
      return
    else
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
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
