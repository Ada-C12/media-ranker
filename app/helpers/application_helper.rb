module ApplicationHelper
  def readable_date(date)
    return "[unknown]" unless date
    return (
      "<span class='date' title='".html_safe +
      date.to_s +
      "'>".html_safe +
      date.to_date.to_s +
      " </span>".html_safe
    )
  end
end
