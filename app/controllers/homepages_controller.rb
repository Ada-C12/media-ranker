class HomepagesController < ApplicationController
  
  def index
    @books = Work.where(category: "book").order(votes_count: :desc).limit(10)
    @albums = Work.where(category: "album").order(votes_count: :desc).limit(10)
    @movies = Work.where(category: "movie").order(votes_count: :desc).limit(10)
    @spotlight = Work.order(votes_count: :desc).first
  end
  
end
