require 'clockwork'
require 'active_support/time'
require File.expand_path('boot', __dir__)
require File.expand_path('environment', __dir__)

module Clockwork
  @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  Clockwork.manager = DatabaseEvents::Manager.new

  sync_database_events model: Users, every: 1.hour do |model_instance|
    container = model_instance.period
    timer = model_instance.send_time.strftime('%R')
  end
  
  handler do |job|
    case job
    when '1day.job'
      Webhook.broadcast
    when '2days.job'
      Webhook.broadcast
    when '3days.job'
      Webhook.broadcast
    when '4days.job'
      Webhook.broadcast
    when '1week.job'
      Webhook.broadcast
    end
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
    config[:logger] = Logger.new(log_file_path)
    config[:tz] = 'JST'
    config[:max_threads] = 15
    config[:thread] = true
  end
end
