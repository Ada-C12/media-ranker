require 'pry'

class WorksController < ApplicationController
    
  before_action :find_work, only: [:show, :edit, :update]

    def index

        @works = Work.all

        @movies = Work.sort_by_category("movie")
        @books = Work.sort_by_category("book")
        @albums = Work.sort_by_category("album")
        
    end
  
    def show
      
      work_id = params[:id].to_i
      @work = Work.find_by(id: work_id)
      if @work.nil?
        head :not_found
        return
      end
    end
  
    def new
        @work = Work.new
    end
  
    def create
      @work = Work.new( work_params )
      @params = work_params[:category]
      if @work.save
        redirect_to work_path(@work.id)
      else
        render new_work_path
      end
    end
  
    def edit
      @work = Work.find_by(id: params[:id] )
    end
  
    def update
      @work = Work.find_by(id: params[:id] )
      
      if @work.update( work_params )
        redirect_to work_path(@work.id)
      else
        render new_work_path
      end
    end
  
    def destroy
  
      work = Work.find_by( id: params[:id] )
  
      
        work.destroy
        flash[:success] = "Successfully destroyed #{work.category} #{work.id}"
        redirect_to root_path
        return
    end

    def spotlight
    end

    def topten
    end


end
