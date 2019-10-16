class HomepagesController < ApplicationController
  def index
    @works = Work.all
    @albums = Work.top_ten_category("album")
    @books = Work.top_ten_category("book")
    @movies = Work.top_ten_category("movie")
  end
end
