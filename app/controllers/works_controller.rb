class WorksController < ApplicationController
  
  def index
    @movies = Movie.all 
    # @books = Book.all
    # @albums = Album.all
    @spotlight_winner = "DO THIS IN WORKS MODEL???"
  end
  
end
