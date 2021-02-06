class BroadcastJob < ApplicationJob
  queue_as :broadcast

  def perform(model)
    container = model.period_id
    timer = model.send_time.strftime("%H:%M")

    return container, timer
  end
end
