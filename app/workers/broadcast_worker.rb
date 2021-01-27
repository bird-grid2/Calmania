class BroadcastWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  require "clockwork"
  sidekiq_options queue: :broadcast

  def expiration
    @expiration ||= 60 * 60 * 24 # 1 day
  end

  def perform(num)
    case num[0]
    when 1
      every(1.day, '1.day.job', at: num[1])
    when 2
      every(2.days, '2.days.job', at: num[1])
    when 3
      every(3.days, '3.days.job', at: num[1])
    when 4
      every(4.days, '4.days.job', at: num[1])
    when 5
      every(7.days, '1.week.job', at: num[1])
    end
  end
end
