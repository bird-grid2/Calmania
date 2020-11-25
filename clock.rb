class Clock
  def send(target)
    url = 'https://api.line.me/v2/bot/message/broadcast'

    access_token = ENV["LINE_ACCESS_TOKEN"]

    text_data = {
      messages: [{
        type: 'text',
        text: '時間になりました。</br>定期入力の時間です。'
      }]
    }

    headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer #{access_token}",
    }

    option = {
      method: 'post',
      headers: headers,
      payload: JSON.stringify(text_data)
    }

    broadcast = UrlFetchApp.fetch(url, option)

    require 'clockwork'
    require 'active_support/time'
    require './config/boot'
    require './config/environment'

    module Clockwork
      Clockwork.manager = DatabaseEvents::Manager.new

      container = 0
      timer = 0

      sync_database_events model: Users, every: 1.hour do |model_instance|
        container = model_instance.find_by(id: target).period
        timer = model_instance.find_by(id: target).send_time
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
  end
end
