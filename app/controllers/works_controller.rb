class WorksController < ApplicationController
  def index
    @movies = Work.by_category("movie")
    @books = Work.by_category("book")
    @albums = Work.by_category("album")
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
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      render new_work_path
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
      flash[:success] = "Successfully updated#{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      render new_work_path
    end
  end

  def destroy
    found_work = Work.find_by(id: params[:id])
    if found_work.nil?
      redirect_to books_path
      return
    else
      found_work.destroy
      flash[:success] = "Successfully destroyed #{found_work.category} #{found_work.id}"
      redirect_to root_path
      return
    end
  end

  def upvote

    work = Work.find_by(id: params[:id])
    vote = Vote.find_by(user_id: session[:user_id], work_id: work.id)


    if session[:user_id]
      if vote 
        flash[:error] = "A problem occurred: you already voted "
      else 
      params = work.upvote(session[:user_id]) 
      Vote.create(user_id: params[:user_id], work_id: params[:work_id])
      flash[:success] = "Successfully upvoted!"
      end 

    else 
      flash[:error] = "A problem occurred: You must log in to do that"
    end 
    redirect_to works_path 
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
