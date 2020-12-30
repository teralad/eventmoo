require 'activerecord-import'
require 'csv'

event_csv_path = Rails.root.join('lib', 'seed_files', 'events.csv')
CSV.foreach(event_csv_path, headers: true) do |row|
  EventCsvRow.new(row).create_event!
end
