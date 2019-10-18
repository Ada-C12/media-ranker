module ApplicationHelper
  def readable_date(date)
    return "[unknown]" unless date
    return (date.strftime("%b %d, %Y"))
  end
end
