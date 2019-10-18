class HomepagesController < ApplicationController
  def index
    @works = Work.all
    @spotlight = Work.spotlight
    @movies = Work.top10("movie")
    @albums = Work.top10("album")
    @books = Work.top10("book")
  end
  
  def show
    homepage_id = params[:id].to_i
    
    @homepage = Homepage.find_by(id: homepage_id)
    if @homepage.nil?
      head :not_found
      return
    end
  end
  
  def new
    @homepage = homepage.new
  end
  
  def create
    @homepage = homepage.new( homepage_params )
    
    if @homepage.save
      redirect_to homepage_path(@homepage.id)
    else
      render new_homepage_path
    end
  end
  
  def edit
    @homepage = Homepage.find_by(id: params[:id] )
  end
  
  def update
    @homepage = Homepage.find_by(id: params[:id] )
    if @homepage.update( homepage_params )
      redirect_to homepage_path(@homepage.id)
    else
      render new_homepage_path
    end
  end
  
  def destroy
    the_correct_homepage = Homepage.find_by( id: params[:id] )
    if the_correct_homepage.nil?
      redirect_to homepages_path
      return
    else
      the_correct_homepage.destroy
      redirect_to root_path
      return
    end
  end
  
  private
  def homepage_params
    return params.require(:homepage).permit(:title, :author_id, :description)
  end
  
end
