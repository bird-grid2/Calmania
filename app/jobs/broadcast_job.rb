class BroadcastJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # do something
  end
end
