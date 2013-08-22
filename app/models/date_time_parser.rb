class DateTimeParser

  attr_reader :date, :time

  def initialize(date, time)
    @date = date
    @time = time
  end

  def parse
    DateTime.parse(stringified_date + "T" + stringified_time)
  end

  def stringified_date
    d = Date.parse(date)
    d.year.to_s + "-" + d.month.to_s + "-" + d.day.to_s
  end

  def stringified_time
    time.gsub(", ", ":")
  end
end