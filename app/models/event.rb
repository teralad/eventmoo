class Event < ApplicationRecord

  # Status created and archived is given so that
  # moderation can be introduced for created events.
  enum status: [:created, :completed, :active, :archived]

  has_many :bookings

  validates_presence_of :start_time
  validates_presence_of :end_time, if: proc { |event| !event.all_day }

  before_create :mark_complete_if_end_date_in_past

  def mark_complete_if_end_date_in_past
    if (end_time.present? && end_time.to_datetime < Time.now.to_datetime) ||
      (all_day && start_time.present? && start_time.to_date < Date.today)
      self.status = self.class.statuses[:completed]
    end
  end

  def get_end_time
    if self.end_time.present?
      self.end_time
    elsif self.all_day
      self.start_time.end_of_day
    end
  end
end
