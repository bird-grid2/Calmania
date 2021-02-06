class BroadcastJob < ApplicationJob
  queue_as :broadcast

  def perform(*args)
    # clockwork is running
  end
end
