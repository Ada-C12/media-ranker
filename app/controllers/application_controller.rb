class ApplicationController < ActionController::Base

  before_action :determine_user


  private

  def determine_user 
    @determine_user = User.find_by(id: session[:user_id])
  end

end
