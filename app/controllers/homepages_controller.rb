class HomepagesController < ApplicationController
  
    
  def index
    @works = Work.all
    @albums= Work.where(category: "album")
    @books = Work.where(category: "book")
    @movies = Work.where(category: "movie")
    
    # work = Work.all

    # 10.times do 
    #   @works << work.sample 
    # end 
    # @works 
  end 
end
