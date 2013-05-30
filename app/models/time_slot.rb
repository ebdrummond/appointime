class TimeSlot
  attr_reader :starts, :ends, :duration

  def initialize(params)
    if params[:starts]
      @starts = Clock.new(params[:starts].hour, params[:starts].min)
    else
      @starts = Time.new(2013, 1, 1, 8)
    end

    if params[:duration]
      @duration = params[:duration]
      @ends = starts + duration
    elsif params[:ends]
      @ends = params[:ends]
      @duration = (ends - starts)/60
    else
      @ends = Time.new(2013, 1, 1, 18)
      @duration = (ends - starts)/60
    end
  end


end