module ApplicationHelper
  def display_date(date_obj)
    return date_obj.getlocal.strftime("%b %d, %Y")
  end
end
