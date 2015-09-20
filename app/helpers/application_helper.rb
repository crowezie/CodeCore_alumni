module ApplicationHelper
  def formatted_date(date)
    date.strftime("%Y-%b-%d")
  end
end
