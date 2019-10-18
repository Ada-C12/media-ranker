class WorksController < ApplicationController
  
  def index
    @works = Work.alpha_works 
  end
  
  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    
    if @work.nil?
      head :not_found
      return
    end
  end
  
  def new
    @work = Work.new
  end
  
  def create
    @work = Work.new(work_params) #instantiate a new work
    if @work.save # save returns true if the database insert succeeds
      flash[:success] = "Work added successfully"
      redirect_to root_path 
      return
    else 
      flash.now[:failure] = "Work failed to save"
      render :new 
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
  
  def update
    @work = Work.find_by(id: params[:id])
    if @work.update(work_params)
      redirect_to root_path 
      return
    else 
      render :edit 
      return
    end
  end
  
  def upvote 

    @vote = Vote.new(date: Date.today, work_id: params[:work_id], user_id: session[:user_id])

    # user_id = @current_user.id
    # work_id = @work.id
    # date = date.today
    # vote_params = {
    #   vote: 
    #   {
    #     user_id: user_id, 
    #     work_id: work_id, 
    #     date: date
    #   }
    # }
    # Vote.create(vote_params)
    # render :show
  end
  
  
  def destroy
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    
    if @work.nil?
      head :not_found
      return
    end
    
    @work.destroy
    
    redirect_to root_path
    return
  end
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication, :description)
  end
  
end
