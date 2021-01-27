require 'net/https'
require 'uri'
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
      uri = URI.parse("https://calmania.work/send")
      http = Net::HTTP.new(uri.host, uri.port)

      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      message = 'test'

      http.start do
        req = Net::HTTP::Post.new(uri.path)
        req.set_form_data({ body: message })
        http.request(req)
      end
    end
  end

  sync_database_events model: ClockWorkEvent, every: 4.hours do |model_instance|
    list = [model_instance.send_time, model_instance.period_id, model_instance.user_id]
    timer = list[0].strftime("%H:%M")
    container = list[1]
    elem = [container, timer]
    
    BroadcastWorker.perform_async(elem)
  end

  configure do |config|
    config[:sleep_timeout] = 5
    config[:max_threads] = 15
    config[:thread] = true
  end
end
