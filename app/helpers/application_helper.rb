module ApplicationHelper
  def readable_date(date)
    return "[unknown]" unless date
    return (
      "<span class='date' title='".html_safe +
      date.to_s +
      "'>".html_safe +
      time_tag(date, :format=> '%b %d, %Y') +
      "</span>".html_safe
    )
  end
end
