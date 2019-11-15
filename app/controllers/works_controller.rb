class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :if_work_missing, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all
  end

  def show; end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:status] = :success
      flash[:message] = "Work added successfully"
      redirect_to work_path(@work)
      return
    else
      flash[:status] = :warning
      flash.now[:message] = "A problem occurred: Could not create #{@work.category}"
      render "new"
      return
    end
  end

  def edit; end

  def update
    if @work.update(work_params)
      redirect_to work_path(@work)
      return
    else
      render "new"
    end
  end

  def destroy
    @work.destroy
    flash[:status] = :success
    flash[:message] = "Successfully destroyed #{@work.category} #{@work.id}"
    redirect_to root_path
    return
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end

  def if_work_missing
    if @work.nil?
      flash[:status] = :danger
      flash[:message] = "Work with ID #{params[:id]} does not exist!"
      redirect_to works_path
      return
    end
  end
end
