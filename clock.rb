require 'net/https'
require 'uri'
require 'clockwork'
require 'clockwork/database_events'
require 'active_support/time'
require File.expand_path('./config/boot', __dir__)
require File.expand_path('./config/environment', __dir__)

module Clockwork
  Clockwork.manager = DatabaseEvents::Manager.new

  sync_database_events model: ClockWorkEvent, every: 4.hours do |model_instance|
    id = model_instance.user_id
    BroadcastWorker.perform_async(id)
  end

  configure do |config|
    config[:sleep_timeout] = 5
    config[:max_threads] = 15
    config[:thread] = true
  end
end
