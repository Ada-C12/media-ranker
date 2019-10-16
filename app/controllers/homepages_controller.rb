class HomepagesController < ApplicationController
  
  def index
    @works = Work.all
  end
  
  def show
    work_id = params[:id]
    @work_item = Work.find_by(id: work_id)
  end
  
  def new
    @work = Work.new
  end
end
