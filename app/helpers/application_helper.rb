module ApplicationHelper
  def parse_date_time(date)
    return 'unknown' unless date
    date.utc.strftime('%m/%d/%Y') 
  end
end
