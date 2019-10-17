class WorksController < ApplicationController
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
      # vote_id: params[:work][:vote_id]
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
end
