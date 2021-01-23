Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://54.238.109.179:6379', namespace: 'sidekiq' }
  Sidekiq::Status.configure_server_middleware config, expiration: 3.minutes
  Sidekiq::Status.configure_client_middleware config, expiration: 3.minutes
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://54.238.109.179:6379', namespace: 'sidekiq' }
  Sidekiq::Status.configure_client_middleware config, expiration: 3.minutes
end
