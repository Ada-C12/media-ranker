module ApplicationHelper

  def readable_date(date)
    return "[unknown]" unless date
    return (
      "<span class='date' title='".html_safe +
      date.to_s +
      "'>".html_safe +
      time_ago_in_words(date) +
      " ago</span>".html_safe
    )
  end

  def s_end?(num)
    if num && num.abs != 1
      return "s"
    end
  end


end

