module ApplicationHelper
  def formatted(input)
    if input.class == Date
      input.strftime("%B %-d")
    else
      input.strftime("%-l:%M")
    end
  end

  def formatted_date(datetime)

  end

  def formatted_time(datetime)

  end
end
