class DatetimeRange < Struct.new(:start_time, :end_time)
  def initialize(*args)
    super
    self.start_time = Time.now if start_time.blank?
    self.end_time = start_time + 2.hour if end_time.blank?
  end
end
