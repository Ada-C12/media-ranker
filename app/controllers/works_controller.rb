class WorksController < ApplicationController
  def index
    @movies = Work.where(category: "movie")
    @albums= Work.where(category: "album")
    @books = Work.where(category: "book")
  end
end
