module ApplicationHelper
  def formatted(input)
    if input.class == Date
      input.strftime("%B %-d")
    elsif input == DateTime
      Time.parse(input).strftime("%-l:%M")
    else
      input.strftime("%-l:%M")
    end
  end
end
