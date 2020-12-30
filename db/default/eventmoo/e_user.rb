require 'activerecord-import'
require 'csv'

include DatabaseHelper

user_csv_path = Rails.root.join('lib', 'seed_files', 'users.csv')
users = []
CSV.foreach(user_csv_path, headers: true) do |row|
  user_data = UserCsvRow.new(row).to_h
  users << User.new(user_data)
  if users.length >= CHUNK_SIZE
    import_records(model_name: User.name, records: users)
    users.clear
  end
end
import_records(model_name: User.name, records: users)
