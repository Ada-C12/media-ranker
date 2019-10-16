class HomepagesController < ApplicationController
  def index
    @work = Work.all 
  end
end
