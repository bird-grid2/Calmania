Warden::JWTAuth.configure do |config|
  config.secret = Rails.application.credentials.secret_key_base
  config.mappings = { user: UserRepository }
end
