class FeaturedController < ApplicationController
  def index
    @works = Work.all
    @user = User.find(session[:user_id]) rescue nil
    
    @featured_work = Work.featured
    
    @sorted_album_works = Work.sort("album")
    @sorted_book_works = Work.sort("book")
    @sorted_movie_works = Work.sort("movie")

  end
end
