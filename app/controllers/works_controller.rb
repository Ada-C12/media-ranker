class WorksController < ApplicationController

  before_action :require_user, only: [:upvote]

  def index
    @works = Work.all
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    if @work.nil?
      redirect to root_path
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new( 
      category: params[:work][:category],
      title: params[:work][:title],
      creator: params[:work][:creator],
      publication_year: params[:work][:publication_year],
      description: params[:work][:description],
      )

      if @work.save
        flash[:success] = "#{@work.title} added successfully"
        redirect_to work_path(@work.id)
      else
        flash.now[:error] = "You didn't do that correctly"
        render new_work_path
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

    if @work.update(
      category: params[:work][:category],
      title: params[:work][:title],
      creator: params[:work][:creator],
      publication_year: params[:work][:publication_year],
      description: params[:work][:description],
      )
      flash[:edit_success] = "You successfully edited a work"
      redirect_to work_path(@work.id)
    else
      render new_work_path
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      redirect_to works_path
    else
      @work.destroy
      flash[:delete] = "You successfully deleted #{@work.title}"
      redirect_to works_path
    end
  end

  def upvote

    @user = User.find_by(id: session[:user_id])
    @work = Work.find_by(id: params[:id])

    #if work.id is in Vote

    if Vote.find_by(user_id: @user.id, work_id: @work.id).nil?

    @vote = Vote.create(user_id: @user.id, work_id: @work.id)

      if @vote
        flash[:success] = "you voted!"
        redirect_to work_path(@work.id)
      end
    else
      flash[:error] = "You've already voted for this work!"
      redirect_to works_path
    end
  end

  private

  def require_user
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      flash[:error] = "you must be logged in"
      redirect_to works_path
    end
  end
end
