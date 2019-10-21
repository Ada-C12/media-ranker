class HomepagesController < ApplicationController
  
  def index
    @spotlight_winner = Work.spotlight_winner
    @top_ten_movies = Work.top_ten_in(category: "movie")
    @top_ten_albums = Work.top_ten_in(category: "album")
    @top_ten_books = Work.top_ten_in(category: "book")
  end
  
  def nope
    # temporary dumping ground
  end
  
end
