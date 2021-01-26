class BroadcastWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  require "clockwork"
  sidekiq_options queue: :broadcast

  def expiration
    @expiration ||= 60 * 60 * 24 # 1 day
  end

  def perform(*args)
    list = [ClockWorkEvent.send_time, ClockWorkEvent.period_id, ClockWorkEvent.user_id]
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
