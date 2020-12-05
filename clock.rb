require 'clockwork'
require 'clockwork/database_events'
require 'active_support/time'
require File.expand_path('./config/boot', __dir__)
require File.expand_path('./config/environment', __dir__)

module Clockwork
  Clockwork.manager = DatabaseEvents::Manager.new

  container = 0
  timer = 0

  sync_database_events model: ClockworkDatabaseEvent, every: 1.hour do |model_instance|
    container = model_instance.period
    timer = model_instance.send_time.strftime('%R')
  end

  handler do |job|
    Webhook.broadcast
  end

  case container
  when '毎日'
    every(1.day, '1day.job', at: timer)
  when '1日毎'
    every(2.day, '2days.job', at: timer)
  when '2日毎'
    every(3.day, '3days.job', at: timer)
  when '3日毎'
    every(4.day, '4days.job', at: timer)
  when '1週間毎'
    every(7.day, '1week.job', at: timer)
  end

  configure do |config|
    config[:sleep_timeout] = 5
    config[:tz] = 'JST'
    config[:max_threads] = 15
    config[:thread] = true
  end
end
