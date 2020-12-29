require 'activerecord-import'
require 'csv'

class EventRow
  def initialize(data)
    starttime,endtime,description,users#rsvp,allday
    @title = data[0]
    @start_time = data[1]
    @end_time = data[2]
    @description = data[3]
    @all_day = data[5].downcase == 'true' ? true : false
    @status = 2
  end

  def to_h
    {
      username: @username,
      email:    @email,
      phone:    clean_phone
    }
  end

  private

  def clean_phone
    @phone = @phone.gsub(/[^0-9A-Za-z]/, '')[/[^Xx]+/]
  end
end


event_csv_path = Rails.root.join('lib', 'seed_files', 'events.csv')
events = []
CSV.foreach(event_csv_path, headers: true) do |row|
  event_data = EventRow.new(row).to_h
  events << User.new(event_data)
  if events.length >= 500
    import_records(model_name: Event.name, records: events)
    users.clear
  end
end
import_records(model_name: Event.name, records: events)
