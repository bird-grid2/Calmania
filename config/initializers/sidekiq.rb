require 'sidekiq'
require 'sidekiq-status'

if Rails.env.production?
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV.fetch('REDIS_URL', 'redis://redis-calmania.lqvkik.0001.apne1.cache.amazonaws.com:6379'), namespace: 'sidekiq' }
    Sidekiq::Status.configure_server_middleware config, expiration: 30.minutes
    Sidekiq::Status.configure_client_middleware config, expiration: 30.minutes
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: ENV.fetch('REDIS_URL', 'redis://redis-calmania.lqvkik.0001.apne1.cache.amazonaws.com:6379'), namespace: 'sidekiq' }
    Sidekiq::Status.configure_client_middleware config, expiration: 30.minutes
  end
end
