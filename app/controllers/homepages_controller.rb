class HomepagesController < ApplicationController
  before_action :current_user
  
  def index
    @works = Work.all
    @media_spotlight = Work.media_spotlight
    @top_ten = Work.top_ten
    @movies = Work.all_movies
    @albums = Work.all_albums
    @books = Work.all_books
  end

end
