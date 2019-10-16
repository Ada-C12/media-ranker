class WorksController < ApplicationController
  def index
    @books = Work.works_by_category("book")
    @movies = Work.works_by_category("movie")
    @albums = Work.works_by_category("album")
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    end
  end
end
