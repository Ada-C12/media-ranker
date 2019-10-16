class HomepagesController < ApplicationController

  def index
    @books = Work.where(category: "book").sample(10)
    @albums = Work.where(category: "album").sample(10)
    @movies = Work.where(category: "movie").sample(10)
    @spotlight = Work.all.sample
  end

end
