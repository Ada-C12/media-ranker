class WorksController < ApplicationController
  
  before_action :find_user 
  
  def new
    @work = Work.new
  end
  
  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to root_path
    else
      render new_work_path
    end
  end
  
  def index
    @works = Work.all
  end
  
  def edit
    @work = Work.find_by(id: params[:id])
    return redirect_to works_path unless @work
  end
  
  def update
    # If the raise below is uncommented AND the app gets to this raise after we click on the "Update Work" button, THEN that means that things are working as expected :D (in terms of edit form -> actually updating)
    # raise
    @work = Work.find_by(id: params[:id])
    return head :not_found unless @work
    if @work.update(work_params)
      redirect_to works_path
    else
      render "edit"
    end
  end
  
  def destroy
    @work = Work.find_by(id: params[:id])
    return redirect_to works_path unless @work 
    update_votes
    @work.destroy
    redirect_to works_path
  end
  
  
  def show
    @work = Work.find_by(id: params[:id])
  end
  
  def update_votes
    @votes = Vote.where(work_id: @work.id)
    @votes.each do |vote|
      vote.work_id = 0
      vote.save
    end 
  end
  
  private
  
  def work_params
    params.require(:work).permit(:name, :description, :creator, :category, :publication_year)
  end
  
  def find_user
    @current_user = User.find_by(id: session[:user_id])
  end
  
end
