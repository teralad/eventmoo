require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  test 'valid booking' do
    booking = Booking.new(event_id: Event.first.id, user_id: User.first.id)
    assert booking.valid?
  end

  test 'invalid booking if user is not present' do
    booking = Booking.new(event_id: Event.first.id)
    refute booking.valid?, 'booking is invalid if user is not present'
    assert_not_nil booking.errors[:user], 'validation error for user absence'
  end

  test 'invalid booking if event is not present' do
    booking = Booking.new(user_id: User.first.id)
    refute booking.valid?, 'booking is invalid if event is not present'
    assert_not_nil booking.errors[:event], 'validation error for event absence'
  end
end
