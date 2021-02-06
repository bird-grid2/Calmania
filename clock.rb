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

  sync_database_events model: ClockWorkEvent, every: 1.hour do |model_instance|
    id = model_instance.user_id
    BroadcastJob.perform_later(id)
    container = @clock.period_id
    timer = @clock.send_time.strftime("%H:%M")
  end

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

  configure do |config|
    config[:sleep_timeout] = 5
    config[:max_threads] = 15
    config[:thread] = true
  end
end
