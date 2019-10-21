module ApplicationHelper
  
  def readable_date(date)
    "<span class='date' title='".html_safe +
    date.to_s +
    "'>".html_safe +
    time_ago_in_words(date) +
    " ago</span>".html_safe
  end
  
end
