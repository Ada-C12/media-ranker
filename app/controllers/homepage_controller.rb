class HomepageController < ApplicationController
    
    def index

        @works = Work.all

        @musics = Work.sort_by_category("music")
        @books = Work.sort_by_category("book")
        @albums = Work.sort_by_category("album")
      
        

    end
  
end
