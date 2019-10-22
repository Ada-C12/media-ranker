class MainpagesController < ApplicationController
  def index
    @works = Work.all
    @albums = Work.where(category: 'album')
    @books = Work.where(category: 'book')
  end
end
