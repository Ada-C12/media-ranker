class WorksController < ApplicationController

  before_action :require_user, only: [:upvote]

  def index
    @albums = Work.album_list
    @books = Work.book_list
    @movies = Work.movie_list
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    if @work.nil?
      redirect_to root_path
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "#{@work.title} added successfully"
      redirect_to work_path(@work.id)
    else
      @error = @work.errors.messages[:title]
      flash.now[:error] = "Error: #{@error}"
      render new_work_path
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

    if @work.update( work_params)
      flash[:edit_success] = "You successfully edited #{@work.title}"
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
      # Since I created a primary key relationship between Work and Vote in Work model, I need to destroy the vote object first
      @votes = Vote.where(work_id: @work.id)
      @votes.each {|vote| vote.destroy }

      @work.destroy
      
      flash[:delete] = "You successfully deleted #{@work.title}"
      redirect_to works_path
    end
  end

  def upvote
    @user = User.find_by(id: session[:user_id])
    @work = Work.find_by(id: params[:id])

    if Vote.find_by(user_id: @user.id, work_id: @work.id).nil?

      @vote = Vote.create(user_id: @user.id, work_id: @work.id)

      flash[:success] = "Yay you voted!"
      redirect_to work_path(@work.id)
    else
      flash[:error] = "You've already voted for this work!"
      redirect_to works_path
    end
  end

  private

  def require_user
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      flash[:error] = "You must be logged in first"
      redirect_to works_path
    end
  end
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
