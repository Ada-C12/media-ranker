class WorksController < ApplicationController
  
  def index
    @everything = Work.all_categories
    @all_movies = Work.all_movies(@everything)
    @all_books = Work.all_books(@everything)
    @all_albums = Work.all_albums(@everything)
  end
  
  def new
    @work = Work.new
  end
  
  def create
    # give default of 0 votes_earned
    @work = Work.new(form_params)
    
    if @work.save
      flash[:success] = "Successfully created #{@work.category}: #{@work.title}"
      redirect_to work_path(id: @work.id)
      return
    else
      flash.now[:error] = "Unsuccessful save"
      render action: "new"
      return
    end
  end
  
  def show
    @work = Work.find_by(id: params[:id].to_i)
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  def form_params
    return params.require(:work).permit(:category, :title, :creator, :published_year, :description)
  end
  
end
