require 'clockwork'
require 'active_support/time'
require './config/boot'
require './config/environment'

module Clockwork
  Clockwork.manager = DatabaseEvents::Manager.new

  container = 0

  sync_database_events model: Users, every: 1.hour do |model_instance|
    container = model_instance.period
  end

  handler do |job|
    case job
    when '1day.job'
      broadcast
    when '2days.job'
      broadcast
    when '3days.job'
      broadcast
    when '4days.job'
      broadcast
    when '1week.job'
      broadcast
    end
  end

  if container == '毎日'
    every(1.day, '1day.job')
  elsif container == '1日毎'
    every(2.day, '2days.job')
  elsif container == '2日毎'
    every(3.day, '3days.job')
  elsif container == '3日毎'
    every(4.day, '1week.job')
  elsif container == '1週間毎'
    every(7.day, '1week.job')
  end

  configure do |config|
    config[:sleep_timeout] = 5
    config[:logger] = Logger.new(log_file_path)
    config[:tz] = 'JST'
    config[:max_threads] = 15
    config[:thread] = true
  end
end
