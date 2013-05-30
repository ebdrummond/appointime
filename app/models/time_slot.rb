class TimeSlot
  attr_reader :starts, :duration

  def initialize(params)
    @starts = params[:starts]
    @duration = params[:duration]
  end

  def ends
    self.starts + (duration * 60)
  end


end