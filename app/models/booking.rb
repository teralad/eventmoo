class Booking < ApplicationRecord
  belongs_to :event
  belongs_to :user
  enum status: [:no, :maybe, :yes]

  validates_presence_of :event
  validates_presence_of :user

  before_create :set_status

  scope :confirmed, -> { where(status: 'yes') }
  scope :overlap, ->(s_time, e_time) { joins(:event).
    where("start_time between ? and ? or end_time between ? and ?
      or start_time < ? and end_time > ?",
      s_time, e_time, s_time, e_time, s_time, e_time)
  }

  def set_status
    s_time = event.start_time
    e_time = event.get_end_time
    accepted_bookings = user.bookings.confirmed.overlap(s_time, e_time).
                                where.not(events: {id: event.id})
    self.status = self.class.statuses['no'] if accepted_bookings.present?
  end
end
