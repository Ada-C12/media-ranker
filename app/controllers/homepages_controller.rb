class HomepagesController < ApplicationController
  def index
    @works = Work.all
    @spotlight = Work.spotlight
    @movies = Work.top10("movie")
    @albums = Work.top10("album")
    @books = Work.top10("book")
  end
  
end
