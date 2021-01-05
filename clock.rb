require 'net/https'
require 'uri'
require 'clockwork'
require 'clockwork/database_events'
require 'active_support/time'
require File.expand_path('./config/boot', __dir__)
require File.expand_path('./config/environment', __dir__)

module Clockwork
  Clockwork.manager = DatabaseEvents::Manager.new

  container = 0
  timer = 0
  targets = []

  sync_database_events model: ClockWorkEvent, every: 1.week do |model_instance|
    list = [model_instance.send_time.strftime("%H:%M"), model_instance.period_id, model_instance.user_id]

    case list[1]
    when 1
      targets.delay(priority: 1).push(list)
    when 2
      targets.delay(priority: 2).push(list)
    when 3
      targets.delay(priority: 3).push(list)
    when 4
      targets.delay(priority: 4).push(list)
    when 5
      targets.delay(priority: 5).push(list)
    end

    handler do |job|
      case job
      when '1.day.job' || '2.days.job' || '3.days.job' || '4.days.job' || '1.week.job'
        uri = URI.parse("https://calmania.work/send")
        http = Net::HTTP.new(uri.host, uri.port)

        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
        req = Net::HTTP::Post.new(uri.path)
        req.set_form_data({'name': 'broadcast', 'content': 'send data'})
    
        res = http.request(req)
    
      end
    end
  
    targets.each do |tar|
      timer = tar[0].strftime("%H:%M")
      container = tar[1]
  
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

  every(1.week, 'reset.job', at: "00:00") { targets = [] }

  configure do |config|
    config[:sleep_timeout] = 5
    config[:max_threads] = 15
    config[:thread] = true
  end
end
