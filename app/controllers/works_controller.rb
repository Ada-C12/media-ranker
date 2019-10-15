class WorksController < ApplicationController
  def index
    @albums = Work.where(category: "album")
    @books = Work.where(category: "book")
    @movies = Work.where(category: "movies")
  end
  
  def main
    @spotlight = Work.spotlight
    @top_movies = Work.top_ten "movie"
    @top_books = Work.top_ten "book"
    @top_albums = Work.top_ten "album"
  end
end
