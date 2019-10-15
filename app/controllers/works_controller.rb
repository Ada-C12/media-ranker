class WorksController < ApplicationController
  
  def index
    @works = Work.all
    @categories = ["movie", "book", "album"]
  end
  
  # show
  # create
  # edit
  # destroy
  
end
