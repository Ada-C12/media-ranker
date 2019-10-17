class HomepageController < ApplicationController
    
    def index

        @works = Work.all

        @movies = Work.sort_by_category("movie")
        @books = Work.sort_by_category("book")
        @albums = Work.sort_by_category("album")
      
        

    end
  
end
