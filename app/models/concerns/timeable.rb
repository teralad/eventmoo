module Timeable
  extend ActiveSupport::Concern
  require 'active_support/all'

  class_methods do
    def between(range:, field: 'created_at')
      where(field.to_sym => range.start_time..range.end_time)
    end
  end

  def is_time_between_interval?(s_t, e_t, given_s_time, given_e_time)
    given_s_time.between?(s_t, e_t) ||
    s_t.between?(given_s_time, given_e_time)
  end

  def enumerate_hours(start, end_)
    Enumerator.new { |y|
      loop { y.yield start.strftime("%Y-%m-%d %H:00:00"); start += 2.hour }
    }.take_while { |d| d <= end_.strftime("%Y-%m-%d %H:00:00") }
  end

  def get_intervals(range)
    s_time = Time.parse(range.start_time).beginning_of_day
    e_time = Time.parse(range.end_time).end_of_day
    enumerate_hours(s_time, e_time)
  end

end
