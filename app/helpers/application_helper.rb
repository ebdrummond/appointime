module ApplicationHelper
  def formatted(input)
    if input.class == Date
      input.strftime("%B %-d")
    else
      Time.parse(input.to_s).strftime("%-l:%M")
    end
  end
end
