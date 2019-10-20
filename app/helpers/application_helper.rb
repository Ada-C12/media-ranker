module ApplicationHelper
  def format_date(date)
    return "[unknown]" unless date
    return (
      "<span title='".html_safe +
      date.to_s +
      "'>".html_safe +
       date.strftime("%b %d, %Y")+
      "</span".html_safe
    )
  end
end
