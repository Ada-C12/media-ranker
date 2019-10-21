class ApplicationController < ActionController::Base

    before_action :determine_user
    private

    def determine_user
    end

    def find_work
      @work = Work.find_by_id(params[:id])
    end

    private
    
    def work_params
        return params.require(:work).permit(:category, :title, :description, :creator, :publication_year)
    end
  



end
