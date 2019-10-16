class WorksController < ApplicationController
  def index
		@movies = Work.by_category("movie")
		@books = Work.by_category("book")
		@albums = Work.by_category("album")
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

  def destory
  end
end
