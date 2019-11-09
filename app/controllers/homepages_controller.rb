class HomepagesController < ApplicationController
  def index
    @works = Work.all
    @top_movies = Work.top_ten("movie") 
    @top_books = Work.top_ten("book") 
    @top_albums = Work.top_ten("album") 
  end
end
