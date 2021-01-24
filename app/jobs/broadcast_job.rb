class BroadcastJob < ApplicationJob
  queue_as :broadcast

  def expiration
    @expiration ||= 60 * 3 # 3 minutes
  end

  def perform(elem, num)
    @container = elem
    @timer = num
  end
end
