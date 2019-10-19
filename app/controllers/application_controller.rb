class ApplicationController < ActionController::Base

  private
  
  def find_loggedin_user
    @user = User.find_by(id: session[:user_id])
  end
end
