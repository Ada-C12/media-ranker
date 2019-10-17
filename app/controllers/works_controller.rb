class WorksController < ApplicationController

  def index
    @works = Work.all
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
    @work = Work.find_by(id: work_id)

    if @work.nil?
      head :not_found
      return
    end
  end

  def update
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

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
    @work = Work.find_by(id: work_id)
  
    if @work.nil?
       head :not_found
       return
    end

    @work.destroy
    redirect_to root_path      
    return
  end

  def upvote
    work = Work.find_by(id: params[:id])
    current_user = User.find_by(id: session[:user_id])

    previous_vote = Vote.where(user_id: current_user.id, work_id: work.id)

    if previous_vote.exists?
      flash[:second_vote] = "You already voted for this work. Please vote for another."
      redirect_to work_path
      return
    else
      @vote = Vote.create(user_id: current_user.id, work_id: work.id, date: Date.today)
      if @vote.save
        flash[:vote] = "Thank you for your vote!"
        redirect_to work_path
        return
      end
    end
    
  end
  

  private

  def work_params
    return params.require(:work).permit(:title, :category, :creator, :publication_year, :description)
  end
end
