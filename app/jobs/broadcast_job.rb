class BroadcastJob < ApplicationJob
  queue_as :broadcast

  def expiration
    @expiration ||= 60 * 60 * 24 # 1 day
  end

  def perform(elem)
    @clock = ClockWorkEvent.find_by(user_id: elem)

    return @clock
  end
end
