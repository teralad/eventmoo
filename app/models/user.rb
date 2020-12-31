class User < ApplicationRecord
  include Timeable

  validates :phone, presence: { message: 'should be present' },
                    numericality: true,
                    length: { minimum: 10, maximum: 15 }
                    # telephone_number: { country: proc{|user_record| user_record.country_iso},
                    #                     types: [:mobile] }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP },
                    presence: { message: 'should be valid' }
  validates_presence_of :username

  has_many :bookings

  def get_availability(range)
    intervals = get_intervals(range).map{|d| {st: d, availability: true} }
    booked_events = bookings.confirmed.overlap(range.start_time, range.end_time)
    booked_timings = booked_events.pluck(:start_time, :end_time)
    intervals.map! do |interval|
      next if !interval[:availability]

      st = Time.parse(interval[:st])
      et = Time.parse(interval[:st]) + 2.hour
      booked_timings.each do |s_time, e_time|
        s_time = Time.parse(s_time.strftime("%Y-%m-%d %H:%M:%S"))
        e_time = Time.parse(e_time.strftime("%Y-%m-%d %H:%M:%S"))
        if is_time_between_interval?(st, et, s_time, e_time)
          interval[:availability] = false
        end
      end
      interval
    end
  end
end
