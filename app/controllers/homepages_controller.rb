class HomepagesController < ApplicationController
    def index 
        @spotlight = Work.spotlight 
        @movies = Work.top_ten("movie")
        @books = Work.top_ten("book")
        @albums = Work.top_ten("album")

    
    end 

end
