class ApplicationController < ActionController::Base

    before_action :determine_user

    private
    def determine_user
        # This deternimes whether a user is logged in and gives an error message if they aren't

    end


    private

    def find_work
      @work = Work.find_by_id(params[:id])
    end

    private
    
    def work_params
        return params.require(:work).permit(:category, :title, :description, :creator, :publication_year)
    end
  



end
