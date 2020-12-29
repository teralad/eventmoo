class Event < ApplicationRecord

  enum status: [:created, :completed, :active]

  has_many :bookings

  validates_presence_of :start_time

  before_create :mark_complete_if_end_date_in_past

  def mark_complete_if_end_date_in_past
    if (end_time.present? && end_time.to_datetime < Time.now.to_datetime) ||
      (all_day && start_time.present? && start_time.to_date < Date.today)
      status = statuses[:completed]
    end
  end
end
