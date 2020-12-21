class BroadcastJob < ApplicationJob
  queue_as :default

  discard_on ActiveJob::DeserializationError

  def perform(*args)
    # 後で実行したい作業をここに書く
  end
end