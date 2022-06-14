class JsonWebToken
  class << self
    def encode(payload)
      JWT.encode(payload, Rails.application.credentials.config[:secret_key_base])
    end

    def decode(token)
      JWT.decode(
        token,
        Rails.application.credentials.config[:secret_key_base]
      )[0]
    rescue ArgumentError
      nil
    end
  end
end
