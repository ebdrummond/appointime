class TimeSlot
  attr_reader :starts, :ends, :duration, :formatted

  def initialize(params)
    if params[:starts]
      @starts = Clock.starts_from(params[:starts])
    else
      @starts = Clock.new(8)
    end

    if params[:duration]
      @duration = params[:duration]
      @ends = starts + duration

    else
      if params[:ends]
        @ends = Clock.from(params[:ends])
      else
        @ends = Clock.new(18)
      end
      @duration = ends - starts
    end

    @formatted = @starts.time.strftime("%-l:%M")
  end

  def ==(other)
    self.starts == other.starts && self.ends == other.ends
  end
end