class HomepagesController < ApplicationController
  def index
    @movies = Work.where(category: "movie")
    @top_movies = 10.times.map { @movies.sample }
    @books = Work.where(category: "book")
    @top_books = 10.times.map { @books.sample }
    @albums = Work.where(category: "album")
    @top_albums = 10.times.map { @albums.sample }
  end
end
