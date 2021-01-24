class BroadcastJob < ApplicationJob
  queue_as :broadcast

  def expiration
    @expiration ||= 60 * 60 * 24 # 1 day
  end

  def perform(elem, num)
    $container = elem
    $timer = num
  end
end
