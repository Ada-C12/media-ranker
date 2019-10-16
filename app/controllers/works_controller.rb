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
    @work.votes_earned = 0
    
    if @work.save
      flash[:success] = "Successfully created #{@work.category}: #{@work.title}"
      # redirect to work#show page
      redirect_to nope_path
      return
    else
      flash.now[:error] = "Unsuccessful save"
      render action: "new"
      return
    end
  end
  
  def show
    work_id = params[:id]
    redirect_to user_path(id: work_id)
    return
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  def form_params
    return params.require[:work].permit(:category, :title, :creator, :published_year, :description)
  end
  
end
