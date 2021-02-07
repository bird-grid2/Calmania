class BroadcastJob < ApplicationJob
  queue_as :broadcast
  
  def perform(*args)
    # do something 
  end
end
