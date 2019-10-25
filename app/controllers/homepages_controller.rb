class HomepagesController < ApplicationController
  
  def index
    @works = Work.all
  end

  def spotlight
  end

end#end of class


#missing: nav bar, media spotlight[top 10], 3 columns of works [movies, albums, books], login button