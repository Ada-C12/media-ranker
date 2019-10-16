class ApplicationController < ActionController::Base

    before_action :determine_user

    private
    def determine_user
        # This deternimes whether a user is logged in and gives an error message if they aren't

    end


end
