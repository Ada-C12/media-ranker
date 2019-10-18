class HomepagesController < ApplicationController

  def index 
    @spotlight = Work.spotlight.first
    @albums_top_ten = Work.album_list.first(10)
    @books_top_ten = Work.book_list.first(10)
    @movies_top_ten = Work.movie_list.first(10)
  end
end
