require 'test_helper'

class LogTest < ActiveSupport::TestCase
  test 'frequency returns the associated period name' do
    user = User.new(
      nickname: 'Example User',
      email: 'example@example.com',
      encrypted_password: 'password',
      jti: 'uuid-example'
    )
    user.build_clock_work_event(period_id: 1)
    log = Log.new(user: user)

    assert_equal '毎日', log.frequency
  end

  test 'frequency returns nil when no reminder settings are present' do
    user = User.new(
      nickname: 'No Reminder',
      email: 'noreminder@example.com',
      encrypted_password: 'password',
      jti: 'uuid-nil'
    )
    log = Log.new(user: user)

    assert_nil log.frequency
  end
end
