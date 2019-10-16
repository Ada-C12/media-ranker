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
  private
  def work_params
    return params.require(:work).permit(:title, :creator, :category, :release_date, :description)
  end
end
