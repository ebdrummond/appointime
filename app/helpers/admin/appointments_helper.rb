module Admin::AppointmentsHelper
  def formatted(input)
    Time.parse(input.to_s).strftime("%-l:%M")
  end
end