class Booking < ApplicationRecord
  belongs_to :event
  belongs_to :user
  enum status: [:no, :maybe, :yes]
end
