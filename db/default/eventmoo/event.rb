require 'activerecord-import'
require 'csv'

CACHE = ActiveSupport::Cache::MemoryStore.new()
class EventObject
  def initialize(data)
    @title = data[0]
    @start_time = data[1]
    @end_time = data[2]
    @description = data[3]
    @rsvp_data = data[4]
    @all_day = data[5].downcase == 'true' ? true : false
    @status = 2
  end

  def to_obj
    @event_object = Event.new(
      title: @title,
      start_time: @start_time,
      end_time: @end_time,
      description: @description,
      all_day: @all_day,
      status: @status
    )
    booking_object = BookingRow.new(@rsvp_data)
    @event_object.bookings.build(booking_object.to_ar)
    @event_object
  end

  class BookingRow
    def initialize(data)
      @rsvp = data
      @booking_obj = []
      process_rsvp
    end

    def to_ar
      @booking_obj
    end

    private
    def get_and_store_user_id(username)
      id = User.find_by(username: username)&.id
      return nil if id.blank?

      CACHE.write(username, id)
      id
    end

    def process_rsvp
      return if @rsvp.blank?

      @rsvp = @rsvp.split(';').map{|d| d.split('#')}.to_h if @rsvp.is_a?(String)
      @rsvp.each do |username, rsvp_status|
        user_id = CACHE.read(username) || get_and_store_user_id(username)
        next unless user_id.present?

        @booking_obj << {
          user_id: user_id,
          status: Booking.statuses[rsvp_status]
        }
      end
    end
  end
end

event_csv_path = Rails.root.join('lib', 'seed_files', 'events.csv')
CSV.foreach(event_csv_path, headers: true) do |row|
  import_records(model_name: Event.name, records: [EventObject.new(row).to_obj], recursive: true)
end
