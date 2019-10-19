module ApplicationHelper
  def readable_date(date)
    return date.localtime.strftime("%B %d, %Y")
  end

  def get_session_username
    user = User.find_by(id: session[:user_id])
    if user
      return user.username
    end

  end

end
