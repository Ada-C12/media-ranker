class HomepagesController < ApplicationController
  def index
    @spotlight_work = Work.highest_rated_work
    @top_books = Work.top_works("book")
    @top_movies = Work.top_works("movie")
    @top_albums = Work.top_works("album")
  end
end
