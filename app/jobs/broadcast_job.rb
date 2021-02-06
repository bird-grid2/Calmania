class BroadcastJob < ApplicationJob
  queue_as :broadcast

  def perform(elem)
    @clock = ClockWorkEvent.find_by(user_id: elem)

    return @clock
  end
end
