Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379', namespace: 'test_sidekiq' }
  Sidekiq::Status.configure_server_middleware config, expiration: 3.minutes
  Sidekiq::Status.configure_client_middleware config, expiration: 3.minutes
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379', namespace: 'test_sidekiq' }
  Sidekiq::Status.configure_client_middleware config, expiration: 3.minutes
end
