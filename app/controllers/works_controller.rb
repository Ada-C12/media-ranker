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
      flash.now[:error] = "A problem occurred: Could not create album
      title: can't be blank"
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
      flash.now[:error] = "A problem occurred: Could not create album
      title: can't be blank"
      render new_work_path
    end
  end

	def destroy

    found_work = Work.find_by( id: params[:id] )
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

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
