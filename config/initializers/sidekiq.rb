require 'sidekiq'
require 'sidekiq-status'

if Rails.env.production?
  Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://calmania-redis.lqvkik.0001.apne1.cache.amazonaws.com:6379', namespace: 'sidekiq' }
    Sidekiq::Status.configure_server_middleware config, expiration: 1.week
    Sidekiq::Status.configure_client_middleware config, expiration: 1.week
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://calmania-redis.lqvkik.0001.apne1.cache.amazonaws.com:6379', namespace: 'sidekiq' }
    Sidekiq::Status.configure_client_middleware config, expiration: 1.week
  end
end
