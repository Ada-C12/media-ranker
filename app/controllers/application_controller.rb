class ApplicationController < ActionController::Base
  before_action :require_log_in, only: [:upvote]
  
  private 
  
  def require_log_in
    @user = User.find_by(id: session[:user_id])
    
    if @user.nil?
      flash[:warning] = "A problem occurred: You must log in to do that"
      redirect_back(fallback_location: root_path)
      return
    end
  end
end
