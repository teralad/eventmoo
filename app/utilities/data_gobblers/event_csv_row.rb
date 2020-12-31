class EventCsvRow

  def initialize(data)
    @title = data[0]
    @start_time = data[1]
    @end_time = data[2]
    @description = data[3]
    @rsvp_data = data[4]
    @all_day = data[5].downcase == 'true' ? true : false
    @status = 2
  end

  def create_event!
    @event = Event.create(
      title: @title,
      start_time: @start_time,
      end_time: @end_time,
      description: @description,
      all_day: @all_day,
      status: @status
    )
    if @event&.id&.present?
      BookingCsvRow.new(@rsvp_data, @event).bulk_insert_bookings!
    end
  end
end
