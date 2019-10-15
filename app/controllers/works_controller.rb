class WorksController < ApplicationController

  def index
    @works = Work.all
  end

  def show
    work_id = params[:id]
    @work = find_by(id: work_id)

    if @work.nil?
      head :not_found
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.create(work_params)

    if @work.save
      redirect_to work_path
      return
    else
      render :new
      return
    end
  end

  def edit
    work_id = params[:id]
    @work = find_by(id: work_id)

    if @work.nil?
      head :not_found
      return
    end
  end

  def update
    work_id = params[:id]
    @work = find_by(id: work_id)

    if @work.nil?
      head :not_found
      return
    end

    if @work.update(work_params)
      redirect_to work_path
      return
    else
      render :edit
      return
    end
  end

  def destroy
    work_id = params[:id]
    @work = find_by(id: work_id)
  
    if @work.nil?
       head :not_found
       return
    end

    @work.destroy
    redirect_to root_path      
    return
  end
  

  private

  def work_params
    return params.require(:work).permit(:title, :category, :creator, :publication_year, :description)
  end
end
