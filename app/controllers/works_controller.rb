class WorksController < ApplicationController
  def index
    @works = Work.all 
  end
  
  def show
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      # Might not be the correct redirect??
      # The page you were looking for doesn't exist. You may have mistyped the address or the page may have moved.
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
      redirect_to work_path(@work.id)  
      # flash: Successfully created book 455
      return
    else 
      render :new  
      return
    end
  end
  
  def edit
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      head :not_found
      return
    end
  end
  
  # <section class="alert__container">
  #     <div class="alert alert-success">
  #       <span>Successfully updated album 299</span>
  #     </div>
  #   </section>
  
  def update
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      head :not_found
      return
    end
    
    if @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
      return
    else
      flash[:warning] = "A prolem occured: Could not update #{@work.category}"  
      render :edit  
      return
    end
  end
  
  def destroy
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      head :not_found
      return
    end
    
    @work.destroy
    
    redirect_to root_path
    # flash: Successfully destroyed album 415
    return
  end
  
  # def upvote
  #   @work = Work.find_by(id: params[:id])
  
  #   if @work.nil?
  #     head :not_found
  #     return
  #   end
  
  # A WHOLE LOT MORE CODE TO ADD A VOTE
  
  #redirect_to work_path(@work.id)
  # flash: Successfully upvoted!
  # but if you're on the index page then you remain there but with the flash message
  # end
  
  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
