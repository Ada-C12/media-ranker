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

  def edit
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      redirect_to works_path
      return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
      return
    end

    if @work.update(work_params)
      redirect_to work_path(@work)
      return
    else
      render "new"
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      redirect_to works_path
      return
    end

    @work.destroy
    flash[:status] = :success
    flash[:message] = "Successfully destroyed #{@work.category} #{@work.id}"
    redirect_to root_path
    return
  end

  def upvote
    @work = Work.find_by(id: params[:id])

    if @work.votes.count == 0
      @work.votes.create(user_id: @current_user.id)
      flash[:status] = :success
      flash[:message] = "Successfully upvoted!"
      redirect_to works_path
      return
    else
      flash[:status] = :warning
      flash[:message] = "A problem occurred: Could not upvote. You have already upvoted this work"
      redirect_to works_path
      return
    end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
