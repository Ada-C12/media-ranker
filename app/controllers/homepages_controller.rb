class HomepagesController < ApplicationController
  def index
    @top_10 = Work.top_10
    @top_1 = Work.top_1
  end
  
end
