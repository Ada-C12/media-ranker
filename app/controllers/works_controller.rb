class WorksController < ApplicationController
  def index
  end
  
  def show
  end
  
  def new
  end
  
  def create
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def work_params
    return params.require(:work).permit(:id, :category, :title, :creator, :pub_year, :description)
  end
end
