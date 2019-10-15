class WorksController < ApplicationController
  def index
    @works = Work.all
    @categories = ["album", "book", "movie"]
  end
end
