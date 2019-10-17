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
  
      the_correct_work = Work.find_by( id: params[:id] )
  
      if the_correct_work.nil?
        redirect_to work_path
        return
      else
        the_correct_work.destroy
        redirect_to root_path
        return
      end
    end

    def spotlight
    end

    def topten
    end

  
    private             
  
    def author_params
      return params.require(:work).permit(:name)
    end

    private

    def find_work
      @work = Work.find_by_id(params[:id])
    end
  
end
