class WorksController < ApplicationController
  def index
    @all_works_categorized = Work.all_works_categorized
  end

  def top_ten
    @top_ten_categorized = Work.top_ten_categorized
    @spotlight = Work.spotlight
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
    if @work.id?
      redirect_to work_path(@work.id)
    else
      render new_work_path, status: :unprocessable_entity
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      redirect_to works_path
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      redirect_to work_path(@work.id)
      return
    else
      render :edit, status: :unprocessable_entity
    end

  end

  def destroy
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      redirect_to works_path
      return
    elsif @work.destroy
      redirect_to works_path
      return
    else
      render :index
    end
  end

end

