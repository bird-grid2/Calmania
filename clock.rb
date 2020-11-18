require 'clockwork'
require 'active_support/time'
require './config/boot'
require './config/environment'


module Clockwork
  handler do |job|
    case job
    when '1day.job'
      # 1day
    when '2days.job'
      # 2days
    when '3days.job'
      # 3days
    when '1week.job'
      # 1week
    end
  end

  every(1.day, '1day.job')
  every(2.day, '2days.job')
  every(3.day, '3days.job')
  every(7.day, '1week.job')

  configure do |config|
    config[:sleep_timeout] = 5
    config[:logger] = Logger.new(log_file_path)
    config[:tz] = 'JST'
    config[:max_threads] = 15
    config[:thread] = true
  end

end