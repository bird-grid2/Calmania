class BroadcastJob < ApplicationJob
  queue_as :default
  discard_on ActiveJob::DeserializationError
  container = 0
  timer = 0

  def expiration
    @expiration ||= 60 * 3 # 3 minutes
  end
  
  def perform(model)
    list = [model.send_time, model.period_id, model.user_id]
    timer = list[0].strftime("%H:%M")
    container = list[1]

    case container
    when 1
      every(1.day, '1.day.job', at: timer)
    when 2
      every(2.days, '2.days.job', at: timer)
    when 3
      every(3.days, '3.days.job', at: timer)
    when 4
      every(4.days, '4.days.job', at: timer)
    when 5
      every(7.days, '1.week.job', at: timer)
    end
  end
end
