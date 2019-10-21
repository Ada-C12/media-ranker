class WorksController < ApplicationController
  
  before_action :find_work, only: [:show, :edit, :update, :destroy]
  
  def index
    @works = Work.all
    @categories = ["movie", "book", "album"]
  end
  
  def show; end
  
  def new
    @work = Work.new
  end
  
  def create 
    if session[:user_id]
      @work = Work.new(work_params)
      if @work.save
        flash[:success] = "Successfully created " + @work.category + " " + @work.id.to_s
        redirect_to work_path(@work.id)
      else
        @errors = @work.errors
        flash.now[:error] = "A problem occurred: Could not create " + @work.category
        render :new
      end
    else
      flash[:error] = "You must log in to do that"
      redirect_to works_path
    end
  end
  
  def edit; end
  
  def update
    if session[:user_id]
      if @work.update(work_params)
        redirect_to work_path
      else
        flash.now[:error] = "A problem occurred: Could not update album"
        render :edit
      end
    else
      flash[:error] = "You must log in to do that"
      redirect_to work_path
    end
  end
  
  def destroy
    if session[:user_id]
      votes = Vote.where(work_id: @work.id)
      votes.destroy_all
      @work.destroy
      flash[:success] = "Successfully destroyed " + @work.category + " " + @work.id.to_s
      redirect_to root_path
    else
      flash[:error] = "You must log in to do that"
      redirect_to works_path
    end
  end
  
  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description )
  end
  
  def find_work
    @work = Work.find(params[:id])
  end
  
end
