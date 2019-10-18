class HomepagesController < ApplicationController

  def index 
    @spotlight = Work.spotlight.first
  end
end
