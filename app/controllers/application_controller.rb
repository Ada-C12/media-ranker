class ApplicationController < ActionController::Base
  def current
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      redirect_to root_path
    end
  end
end
