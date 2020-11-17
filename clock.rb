require 'clockwork'
require 'active_support/time'
require './config/boot'
require './config/environment'


module Clockwork
  handler do |job|
    case job
    when '1day.job'
      # 10 秒毎の処理
    when '2days.job'
      # 3 分毎の処理
    when '3days.job'
      # 1 時間毎の処理
    when '1week.job'
      # 夜中の処理（なんだかエロい…）
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