class HomepagesController < ApplicationController
  def index
    @top_10_movies = Work.top_10_movies
    @top_10_albums = Work.top_10_albums
    @top_10_books = Work.top_10_books
    @top_1 = Work.top_1
  end
  
end
