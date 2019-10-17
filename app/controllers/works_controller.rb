class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :if_work_missing, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all
  end

  def show; end

  # @work = Work.find_by(id: params[:id])

  # if @work.nil?
  #   redirect_to works_path
  #   return
  # end

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

  # @work = Work.find_by(id: params[:id])

  # if @work.nil?
  #   redirect_to works_path
  #   return
  # end

  def update
    # @work = Work.find_by(id: params[:id])

    # if @work.nil?
    #   redirect_to works_path
    #   return
    # end

    if @work.update(work_params)
      redirect_to work_path(@work)
      return
    else
      render "new"
    end
  end

  def destroy
    # @work = Work.find_by(id: params[:id])

    # if @work.nil?
    #   redirect_to works_path
    #   return
    # end

    @work.destroy
    flash[:status] = :success
    flash[:message] = "Successfully destroyed #{@work.category} #{@work.id}"
    redirect_to root_path
    return
  end

  # def upvote
  # @work = Work.find_by(id: params[:id])

  # if @work.votes.count == 0
  #   @work.votes.create(user_id: @current_user.id)
  #   flash[:status] = :success
  #   flash[:message] = "Successfully upvoted!"
  #   redirect_to works_path
  #   return
  # else
  #   flash[:status] = :warning
  #   flash[:message] = "A problem occurred: Could not upvote. You have already upvoted this work"
  #   redirect_to works_path
  #   return
  # end
  # end

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
