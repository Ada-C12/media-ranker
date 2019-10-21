class HomepagesController < ApplicationController
  def index
    @works = Work.all
    @movies = Work.category_list("movie").slice(0..9)
    @books = Work.category_list("book").slice(0..9)
    @albums = Work.category_list("album").slice(0..9)
  end
end
