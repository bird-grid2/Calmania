class BroadcastWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  include Clockwork
  sidekiq_options queue: :broadcast

  def expiration
    @expiration ||= 60 * 60 * 24 # 1 day
  end

  def perform(elem)
    @clock = ClockWorkEvent.find_by(user_id: elem)
    container = @clock.period_id
    timer = @clock.send_time.strftime("%H:%M")
  end
end
