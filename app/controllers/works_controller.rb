class WorksController < ApplicationController
  def home
  end 

  def index
    @works = Work.all
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
    @work = Work.create(work_params)

    if @work.save
      flash[:success] = "Work  #{@work.id} added succesfully!"
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "You didn't do it right!"
      render new_work_path
    end 
  end 

  def edit 
    @work = Work.find_by(id: params[:id])
  end 

  def update
    @work = Work.find_by(id: params[:id])

    if @work.update(work_params)
      redirect_to work_path(@work.id)
    else
      render new_work_path
    end
  end 

  def destroy 
    work = Work.find_by(id:params[:id])

    if work.nil?
      redirect_to works_path
      return
    else 
      work.destroy
      flash[:delete] = "You deleted work #{work.title}"
      redirect_to works_path
      return
    end
  end 


  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end 

end
