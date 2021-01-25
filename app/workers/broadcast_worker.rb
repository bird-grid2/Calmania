class BroadcastWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  def expiration
    @expiration ||= 60 * 60 * 24 # 1 day
  end

  def perform(model)
    list = [model.send_time, model.period_id, model.user_id]
    timer = list[0].strftime("%H:%M")
    container = list[1]
  end
end
