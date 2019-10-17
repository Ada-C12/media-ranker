module ApplicationHelper
  def readable_date(date)
    return date.strftime("%B %d, %Y")
  end

end
