class HomepagesController < ApplicationController
  
  def index
    @works = Work.all
  end
  
  def show
  end
  
  def new
  end
end
