class BroadcastJob < ApplicationJob
  queue_as :broadcast

  def expiration
    @expiration ||= 60 * 3 # 3 minutes
  end

  def perform(model)
    list = [model.send_time, model.period_id, model.user_id]
    timer = list[0].strftime("%H:%M")
    container = list[1]
  end
end
