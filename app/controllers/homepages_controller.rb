class HomepagesController < ApplicationController
  def index
    @works = Work.all
    @albums = Work.top_ten("album")
    @books = Work.sort_by_category("book").slice(0..9)
    @movies = Work.sort_by_category("movie").slice(0..9)
  end
end
