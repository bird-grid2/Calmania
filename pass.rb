require 'bcrypt'
require 'warden'
require 'jwt'
require 'pry'
require_relative 'config/environment'

payload = {
  jti: 'fjaojfowfhoanoieerjafoijefaojf858025290588502jfjfoawja',
  exp: 1717156800,
  scp: 'api_v1_user',
  user: {
    id: 'test-id',
    email: 'test@sample.co.jp',
    nickname: 'test-user'
  }
}

hashed_password = JWT.encode(payload, Rails.application.credentials.secret_key_base)
revoker = Warden::JWTAuth::TokenRevoker.new

begin
  revoker.call(hashed_password)
rescue NoMethodError => e
  puts "エラー出力 #{e.message}"
end
