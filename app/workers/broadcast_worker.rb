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
  end

  def self.send
    @clock
  end
end
