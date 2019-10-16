class WorksController < ApplicationController
  def index
    @books = Work.works_by_category("book")
    @movies = Work.works_by_category("movie")
    @albums = Work.works_by_category("album")
  end
end
