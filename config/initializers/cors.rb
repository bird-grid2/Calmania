Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    if Rails.env.development?
      origins "http://localhost:3000", "http://localhost:8080"
    elsif Rails.env.production?
      origins "https://calmania.work", "http://locakhost:8080"
    end

    resource '*', headers: :any, methods: [:get, :post, :patch, :put, :delete, :options, :head]
  end
end