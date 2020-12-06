require 'clockwork'
require 'clockwork/database_events'
require 'active_support/time'
require File.expand_path('./config/boot', __dir__)
require File.expand_path('./config/environment', __dir__)

module Clockwork
  Clockwork.manager = DatabaseEvents::Manager.new

  container = 0
  timer = 0

  sync_database_events model: User, every: 1.hour do |model_instance|
    container = model_instance.delay.period
    timer = model_instance.delay.sendtime
  end

  handler do |job|
    job
  end

  case container
  when 1
    every(1.day, '1day.job', at: timer) { Webhook.broadcast }
  when 2
    every(2.days, '2days.job', at: timer) { Webhook.broadcast }
  when 3
    every(3.days, '3days.job', at: timer) { Webhook.broadcast }
  when 4
    every(4.days, '4days.job', at: timer) { Webhook.broadcast }
  when 5
    every(7.days, '1week.job', at: timer) { Webhook.broadcast }
  end

  configure do |config|
    config[:sleep_timeout] = 5
    config[:max_threads] = 15
    config[:thread] = true
  end
end
