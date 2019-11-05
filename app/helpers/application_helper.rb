module ApplicationHelper
  
  def pluralized?(word, num)
    return word unless num != 1
    return word + 's'
  end

  def formatted_date(date)
    return date.strftime('%b %d, %Y')
  end

  def flash_class(level)
    case level.to_sym
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-error"
    when :alert then "alert alert-error"
    end
  end
end
