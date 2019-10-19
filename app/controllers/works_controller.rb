class WorksController < ApplicationController
  
  def index
    @movies = Work.where(category: "movies")
    @books = Work.where(category: "books")
    @albums = Work.where(category: "albums")
    @spotlight = Work.all.sample(10)
  end
  
  def show
    @work = Work.find_by(id: params[:id])
    
  end
  
  def create
    @work = Work.new(work_params) #instantiate a new work
    if @work.save # save returns true if the database insert succeeds
      flash[:success] = "Work added successfully"
      redirect_to root_path # go to the index so we can see the work in the list
      return
    else # save failed :(
      flash.now[:failure] = "work failed to save"
      render :new # show the new work form view again
      return
    end
  end
  
  def new
    if params[:user_id]
      # This is the nested route, /user/:user_id/works/new
      user = User.find_by(id: params[:user_id])
      @work = user.works.new
      
    else
      # This is the 'regular' route, /works/new
      @work = Work.new
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
      redirect_to root_path # go to the index so we can see the work in the list
      return
    else # save failed :(
      render :edit # show the new work form view again
      return
    end
  end
  
  def destroy
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    if @work.nil?
      head :not_found
      return
    end
    @work.destroy
    redirect_to works_path
    return
  end
  
  private 
  def work_params
    return params.require(:work).permit(:category, :title, :creator,
      :description, :publication_date)
    end
    
  end#end of class
  