module ApplicationHelper
  def find_user
    found_user = User.find_by(id: session[:user_id])
    return found_user
  end
end
