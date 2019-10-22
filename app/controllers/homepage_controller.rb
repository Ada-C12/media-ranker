class HomepageController < ApplicationController
    
    def index
        @spotlight = Work.spotlight
        @top_ten_movies = Work.highest_ten("movie")
        @top_ten_books = Work.highest_ten("book")
        @top_ten_albums = Work.highest_ten("album")
    end
end
