class BroadcastWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  require "clockwork"
  sidekiq_options queue: :broadcast

  def expiration
    @expiration ||= 60 * 60 * 24 # 1 day
  end

  def perform(elem, num)
    
    case elem
    when 1
      every(1.day, '1.day.job', at: num)
    when 2
      every(2.days, '2.days.job', at: num)
    when 3
      every(3.days, '3.days.job', at: num)
    when 4
      every(4.days, '4.days.job', at: num)
    when 5
      every(7.days, '1.week.job', at: num)
    end
  end
end
