class TimeSlot
  attr_reader :starts, :ends, :duration

  def initialize(params)
    @starts = params.fetch(:starts) {Time.new(2013, 1, 1, 8)}
    if params[:duration]
      @duration = params[:duration]
      @ends = starts + (duration * 60)
    elsif params[:ends]
      @ends = params[:ends]
      @duration = (ends - starts)/60
    else
      @ends = Time.new(2013, 1, 1, 18)
      @duration = (ends - starts)/60
    end
  end


end