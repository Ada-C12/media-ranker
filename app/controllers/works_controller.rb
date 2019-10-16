class WorksController < ApplicationController
  def index
    @works = Work.all
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
      flash[:success] = "Media added successfully!"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:failure] = "Media failed to save!"
      render :new
      return
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      redirect_to edit_work_path
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
      flash[:success] = "Media edited successfully!"
      redirect_to work_path(@work.id)
    else
      flash.now[:failure] = "Media failed to update!"
      render :edit
      return
    end
  end

  def destroy
    work = Work.find_by(id: params[:id])
    if work.nil?
      head :not_found
      return
    end
    if work.destroy
      flash[:success] = "Work successfully deleted!"
      redirect_to works_path
      return
    end
  end

  private
  def work_params
    return params.require(:work).permit(:title, :creator, :category, :release_date, :description)
  end
end
