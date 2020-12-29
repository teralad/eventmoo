require 'activerecord-import'
require 'csv'

class UserRow
  def initialize(data)
    @username = data[0]
    @email    = data[1]
    @phone    = data[2]
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

include DatabaseHelper

user_csv_path = Rails.root.join('lib', 'seed_files', 'users.csv')
users = []
CSV.foreach(user_csv_path, headers: true) do |row|
  user_data = UserRow.new(row).to_h
  users << User.new(user_data)
  if users.length >= CHUNK_SIZE
    import_records(model_name: User.name, records: users)
    users.clear
  end
end
import_records(model_name: User.name, records: users)
