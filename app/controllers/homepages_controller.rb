class HomepagesController < ApplicationController
  def index
    @user = User.find_by(id: session[:user_id])
    @works = Work.all
    @movies = Work.by_category("movie")
    @albums = Work.by_category("album")
    @books = Work.by_category("book")
  end
end
