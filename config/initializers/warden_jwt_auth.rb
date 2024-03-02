Warden::JWTAuth.configure do |config|
  config.secret = Rails.application.credentials.secret_key_base
  config.algorithm = 'HS256'
  config.mappings = { user: UserRepository }
end
