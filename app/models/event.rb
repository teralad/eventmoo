class Event < ApplicationRecord

  # Status created and archived is given so that
  # moderation can be introduced for created events.
  enum status: [:created, :completed, :active, :archived]

  has_many :bookings

  validates_presence_of :start_time
  validates_presence_of :end_time, if: proc { |event| !event.all_day }

  before_create :mark_complete_if_end_date_in_past

  def end_time_is_in_past
    end_time.present? && end_time.to_datetime < Time.now.to_datetime
  end

  def start_time_is_in_past
    all_day && start_time.present? && start_time.to_date < Date.today
  end

  def mark_complete_if_end_date_in_past
    return unless (end_time_is_in_past || start_time_is_in_past)

    self.status = self.class.statuses[:completed]
  end

  def get_end_time
    return end_time if end_time.present?

    self.start_time.end_of_day if self.all_day
  end
end
