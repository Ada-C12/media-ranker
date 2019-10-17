class HomepagesController < ApplicationController
  
    
  def index
    @works = Work.all
  
    # work = Work.all

    # 10.times do 
    #   @works << work.sample 
    # end 
    # @works 
  end 
end



