class ApplicationJob < ActiveJob::Base
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
end
