class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    
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
      return
    else 
      render :new
      return
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      redirect_to work_path(@work.id)
      return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      redirect_to work_path(@work.id)
      return
    end
    
    if @work.update(
      category: params[:work][:category], 
      title: params[:work][:title], 
      creator: params[:work][:creator],
      publication_year: params[:work][:publication_year],
      description: params[:work][:description],
    )
      redirect_to works_path
      return
    else 
      render :edit 
      return
    end
  end

  def destroy
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    if @work.nil?
      redirect_to works_path
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


