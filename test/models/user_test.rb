require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid user' do
    user = User.new(username: 'John', email: 'john@example.com', phone: '1232522325')
    assert user.valid?
  end

  test 'invalid without name' do
    user = User.new(email: 'john@example.com')
    refute user.valid?, 'user is invalid without a username'
    assert_not_nil user.errors[:username], 'validation error for name present'
  end

  test 'invalid without email' do
    user = User.new(username: 'John')
    refute user.valid?
    assert_not_nil user.errors[:email]
  end

  test 'invalid without phone' do
    user = User.new(email: 'john@example.com', username: 'john')
    refute user.valid?, 'user is invalid without a phone'
    assert_not_nil user.errors[:phone], 'validation error for name present'
  end

end
