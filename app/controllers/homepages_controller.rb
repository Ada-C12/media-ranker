class HomepagesController < ApplicationController
  def index
    @movies = Work.where(category: "movie")
    @top_movies = @movies.sample(10)
    @books = Work.where(category: "book")
    @top_books = @books.sample(10)
    @albums = Work.where(category: "album")
    @top_albums = @albums.sample(10)
  end
end
