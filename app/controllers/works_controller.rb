class WorksController < ApplicationController
  
  def index
    @works = "Work.all but not implemented yet"
    @spotlight_winner = "DO THIS IN WORKS MODEL???"
  end
  
  def new
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
  
  private
  def form_params
    return params.require[:work].permit(:category, :title, :creator, :published_year, :description)
  end
  
end
