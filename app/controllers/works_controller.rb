class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update]

  def index
    @works = Work.all
  end

  def show
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
    @work.vote_count = 0
    
    if @work.save
      redirect_to work_path(@work.id)
      flash[:success] = "#{@work.title} added successfully"
    else
      flash.now[:error] = @work.errors.messages
      render new_work_path
      return
    end
  end

  def edit
    if @work.nil?
      head :not_found
      return
    end
  end

  def update
    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      flash[:success] = "#{@work.title} updated successfully"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:error] = "Work NOT updated successfully"
      render edit_work_path
      return
    end
  end

  def destroy
    work = Work.find_by(id: params[:id])
    if work.nil?
      head :not_found
      return
    elsif work.destroy
      flash[:success] = "#{work.title} deleted successfully"
      redirect_to works_path
      return
    else
      flash[:error] = "Work NOT deleted successfully"
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description, :vote_count)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end
end
