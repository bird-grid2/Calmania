class BroadcastJob < ApplicationJob
  queue_as :broadcast

  def perform(model)
    id = ClockWorkEvent.find_by(user_id: model)
    container = id.period_id
    timer = id.send_time.strftime("%H:%M")

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
