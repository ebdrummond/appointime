class Clock
  def self.from(time)

    Clock.new(time.hour, time.min)
  end

  def self.starts_from(time)
    t = time.strftime("%H:%M").split(":")
    Clock.new(t.first.to_i, t.last.to_i)
  end

  attr_accessor :time, :hour, :minutes

  def initialize(hour, minutes = 0)
    @hour = hour
    @minutes = minutes
    @time = Time.new(1970, 1, 1, hour, minutes)
    clean_input if hour.is_a?(String)
  end

  def clean_input
    split_time = hour.split(", ")
    self.hour = split_time.first.to_i
    self.minutes = split_time.last.to_i
    self.time = Time.new(1970, 1, 1, hour, minutes)
  end

  def to_s
    time.strftime("%H:%M")
  end

  def +(minutes)
    new_time = time + (minutes * 60)
    Clock.new(new_time.hour, new_time.min)
  end

  def -(diff)
    if diff.is_a?(Fixnum)
      new_time = time - (diff * 60)
      Clock.new(new_time.hour, new_time.min)
    else
      (time - diff.time)/60
    end
  end

  def ==(other)
    self.hour == other.hour && self.minutes == other.minutes
  end

end