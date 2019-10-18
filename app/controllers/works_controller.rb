class WorksController < ApplicationController
  def index
    @albums = Work.sort('album')
    @books = Work.sort('book')
  end

  def new
    @work = Work.new
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
      head :not_found
      return
    end
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "Work added successfully"
      redirect_to works_path
      return
    else
      flash.now[:failure] = "Work failed to save"
      render :new
      return
    end
  end

  def update
    @work = work.find_by(id: params[:id])

    if @work.update(work_params)
      redirect_to work_path(@work)
      return
    else
      render :edit
      return
    end
  end

  def destroy
    @work = work.find_by(id: params[:id])

    if @work.nil?
      flash[:error] = "Could you find media #{@work.name}"
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
