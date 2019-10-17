module ApplicationHelper
  
  def display_date(date_obj)
    return date_obj.getlocal.strftime("%b %d, %Y")
  end
  
  def username_from_session
    found_user = User.find_by(id: session[:user_id])
    if found_user
      return found_user.name
    else
      raise ArgumentError, "bad session[:user_id]"
    end
  end
  
end
