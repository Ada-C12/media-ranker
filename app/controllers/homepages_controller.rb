class HomepagesController < ApplicationController
  def index
    @spotlight_work = Work.highest_rated_work
    @top_books = Work.top_works_sorted_by_category("book")
    @top_movies = Work.top_works_sorted_by_category("movie")
    @top_albums = Work.top_works_sorted_by_category("album")
  end
end
