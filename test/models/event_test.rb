require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test 'valid event' do
    event = Event.new(title: "Tuna sashimi Fest", start_time: Time.now, end_time: Time.now+1.day)
    assert event.valid?
  end

  test 'valid event if end_time is nil and all_day is true' do
    event = Event.new(title: "Tuna sashimi Fest", start_time: Time.now, all_day: true)
    assert event.valid?
  end

  test 'invalid event if end_time is nil and all_day is false' do
    event = Event.new(title: "Tuna sashimi Fest", start_time: Time.now, all_day: false)
    refute event.valid?, 'event is invalid without a end_time if all_day is false'
    assert_not_nil event.errors[:end_time], 'validation error for end_time present'
  end

  test 'invalid event if start_time is not present' do
    event = Event.new(title: "Tuna sashimi Fest")
    refute event.valid?, 'event is invalid without a start_time'
    assert_not_nil event.errors[:start_time], 'validation error for start_time present'
  end

end
