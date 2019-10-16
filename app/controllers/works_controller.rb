class WorksController < ApplicationController
  
  def index
    @works = Work.order(:title)
  end
  
  def show
    @work = Work.find_by(id: params[:id])
  end
  
  def create
    
  end
  
  def new
    
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def login
    
  end
  
  def logout
    
  end
  
  def destroy
    
  end
end#end of class
