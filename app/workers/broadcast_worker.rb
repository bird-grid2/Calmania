class BroadcastWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  require 'net/https'
  require 'uri'
  require 'clockwork'
  sidekiq_options queue: :broadcast

  def expiration
    @expiration ||= 60 * 60 * 24 # 1 day
  end

  def perform(elem)
    @clock = ClockWorkEvent.find_by(user_id: elem)

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

    container = @clock.period_id
    timer = @clock.send_time.strftime("%H:%M")

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
