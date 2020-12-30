class BookingCsvRow
  @@cache = ActiveSupport::Cache::MemoryStore.new()

  def initialize(data, event)
    @event = event
    @rsvp = data
    @booking_obj = []
    process_rsvp
  end

  def bulk_insert_bookings!
    Booking.import! @booking_obj, validate: false
  end

  private
  def get_and_store_user_id(username)
    id = User.find_by(username: username)&.id
    return nil if id.blank?

    @@cache.write(username, id)
    id
  end

  def confirmed_bookings_list(u_id)
    s_time, e_time = @event.start_time, @event.end_time
    Booking.confirmed.overlap(s_time, e_time).where(user_id: u_id)
  end

  def process_rsvp
    return if @rsvp.blank?

    @rsvp = @rsvp.split(';').map{|d| d.split('#')}.to_h if @rsvp.is_a?(String)
    @rsvp.each do |username, rsvp_status|
      user_id = @@cache.read(username) || get_and_store_user_id(username)
      next unless user_id.present?
      bookings = rsvp_status.downcase == 'yes' ? confirmed_bookings_list(user_id) : nil

      @booking_obj << {
        event_id: @event.id,
        user_id: user_id,
        status: (bookings.present? ? Booking.statuses['no'] : Booking.statuses[rsvp_status])
      }
    end
  end
end
