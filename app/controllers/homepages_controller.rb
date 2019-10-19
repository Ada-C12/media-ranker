class HomepagesController < ApplicationController
  def index
    # take top ten books
    @books = Work.top_ten("book")
    # take top ten albums
    @albums = Work.top_ten("album")
    # take top ten movies
    @movies = Work.top_ten("movie")

    # find the one with highest votes
    @spotlight = Work.spotlight 
  end
end