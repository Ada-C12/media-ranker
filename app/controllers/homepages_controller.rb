class HomepagesController < ApplicationController
  
  def index
    # I did it this way so it's 3x faster
    @everything = Work.all_categories
    @top_ten_movies = Work.top_ten_movies(@everything)
    @top_ten_books = Work.top_ten_books(@everything)
    @top_ten_albums = Work.top_ten_albums(@everything)
    @spotlight_winner = Work.spotlight_winner
  end
  
  def nope
    # temporary dumpign ground
  end
  
end
