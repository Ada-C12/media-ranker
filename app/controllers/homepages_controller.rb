class HomepagesController < ApplicationController

  def index
    @books = Work.top_ten("book")
    @albums = Work.top_ten("album")
    @movies = Work.top_ten("movie")
    @spotlight = Work.spotlight
  end

end
