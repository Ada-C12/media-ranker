class HomepagesController < ApplicationController
  def index
    @works = Work.all
    @categories = ["movie", "book", "album"]
  end
end
