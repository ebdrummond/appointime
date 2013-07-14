module ApplicationHelper
  def formatted(input)
    if input.class == Date
      input.strftime("%B %-d")
    else
      input.strftime("%-l:%M")
    end
  end
end
