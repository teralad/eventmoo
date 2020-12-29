require 'activerecord-import'
require 'csv'

user_csv_path = Rails.root.join('lib', 'seed_files', 'users.csv')
users = []
CSV.foreach(user_csv_path) do |row|
  users << User.new do |user|
    user.username = row[0]
    user.email    = row[1]
    user.phone    = row[2]
  end
end
