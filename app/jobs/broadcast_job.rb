class BroadcastJob < ApplicationJob
  queue_as :broadcast

  def perform(*args)
    # clockworks running
  end
end
