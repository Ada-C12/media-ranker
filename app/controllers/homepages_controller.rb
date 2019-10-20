class HomepagesController < ApplicationController
  def index
    @spotlight = Work.spotlight

    @top_ten_movies = Work.top_ten("movie")
    @top_ten_books = Work.top_ten("book")
    @top_ten_albums = Work.top_ten("album")
  end
end
