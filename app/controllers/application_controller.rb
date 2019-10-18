class ApplicationController < ActionController::Base
  before_action :find_user
  before_action :find_work
  
  private
  
  def find_user
    if params[:id] || session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end
  
  def find_work
    if params[:id]
      @work = Work.find(params[:id])
    end
  end
  
end
