class WorksController < ApplicationController
  
  # before_action :find_work, only: [show, edit, update, destroy]
  
  def index
    @works = Work.all
    @categories = ["movie", "book", "album"]
  end
  
  # show
  # create
  # edit
  # destroy
  
end
