class BroadcastJob < ApplicationJob
  queue_as :broadcast
  container = 0
  timer = 0

  def perform(model)
    container = model.period_id
    timer = model.send_time.strftime("%H:%M")
  end
end
