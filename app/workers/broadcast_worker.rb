class BroadcastWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  require "clockwork"
  sidekiq_options queue: :broadcast

  def expiration
    @expiration ||= 60 * 60 * 24 # 1 day
  end

  def perform(elem)
    @clock = ClockWorkEvent.find_by(user_id: elem)
    p "hello world"
  end
end
