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
    @work = Work.new( work_params )
    if @work.save
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "A problem occured: Could not create #{@work.category}"
      render new_work_path
    end
  end

  def edit
  end

  def update
    if @work.update( work_params )
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "A problem occurred: Could not update #{@work.category}"
    end
  end

  def destroy
    the_correct_work = Work.find_by(id: params[:id])
    if the_correct_work.nil?
      redirect_to root_path
    else
      the_correct_work.destroy
      flash[:success] = "Successfully destroyed #{the_correct_work.category} #{the_current_work.id}"
      redirect_to root_path
    end
  end

  private

  def find_work
    @work = Work.find_by(id: params[:id])
  end

  def work_params
    params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
