class ApplicationController < ActionController::Base
  before_action :find_user
  before_action :find_work
  
  private
  
  def find_user
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
  end
  
  def find_work
    if params[:work]
      @work = Work.find(params[:id])
    end
  end
  
end
