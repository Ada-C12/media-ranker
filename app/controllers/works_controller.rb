class WorksController < ApplicationController
  def index
    @movies = Work.where(category: "movie")
    @albums= Work.where(category: "album")
    @books = Work.where(category: "book")
  end

  def new
    @work = Work.new
  end 

  def create
    @work = Work.new(category: params[:work][:category], title: params[:work][:title], creator: params[:work][:creator], publication_year: params[:work][:publication_year], description: params[:work][:description] )
    
    if @work.save 
      flash[:sucess] = "Work added successfully"
      redirect_to root_path
      return
    else
      flash.now[:failure] = "Work did not add successfully"
      render :new 
      return 
    end
  end 
end
