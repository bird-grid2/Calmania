require 'clockwork'
require 'clockwork/database_events'
require 'active_support/time'
require File.expand_path('./config/boot', __dir__)
require File.expand_path('./config/environment', __dir__)

module Clockwork
  Clockwork.manager = DatabaseEvents::Manager.new

  handler do |job|
    case job
    when '1.day.job' || '2.days.job' || '3.days.job' || '4.days.job' || '1.week.job'
      BroadcastJob.perform_later(job)
    end
  end

  sync_database_events model: ClockWorkEvent, every: 1.hour do |model_instance|
    container = model_instance.period_id
    timer = model_instance.send_time.strftime("%H:%M")

    case container
    when 0
      exit
    when 1
      every(1.day, '1.day.job', at: timer)
    when 2
      every(2.days, '2.days.job', at: timer)
    when 3
      every(3.days, '3.days.job', at: timer)
    when 4
      every(4.days, '4.days.job', at: timer)
    when 5
      every(1.week, '1.week.job', at: timer)
    end
  end

  configure do |config|
    config[:sleep_timeout] = 5
    config[:max_threads] = 15
    config[:thread] = true
  end
end
