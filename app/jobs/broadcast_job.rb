class BroadcastJob < ApplicationJob
  queue_as :default

  discard_on ActiveJob::DeserializationError

  def perform(*args)
    # do something
  end
end
