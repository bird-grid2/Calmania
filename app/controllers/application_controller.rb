class ApplicationController < ActionController::API
  require 'pycall'
  require 'pycall/import'
  require 'matplotlib/pyplot'
  require 'numpy'
  include ActionController::MimeResponds
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionView::Layouts
  respond_to :json
  attr_reader :current_user

  def after_sign_in_path_for(*)
    managements_path
  end

  def after_sign_out_path_for(*)
    root_path
  end

  # 400 Bad Request
  def response_bad_request
    render status: 400, json: { status: 400, message: 'Bad Request' }
  end

  # 401 Unauthorized
  def response_unauthorized
    render status: 401, json: { status: 401, message: 'Unauthorized' }
  end

  # 404 Not Found
  def response_not_found(class_name)
    render status: 404, json: { status: 404, message: "#{class_name.capitalize} Not Found" }
  end

  # 409 Conflict
  def response_conflict(class_name)
    render status: 409, json: { status: 409, message: "#{class_name.capitalize} Conflict" }
  end

  # 500 Internal Server Error
  def response_internal_server_error
    render status: 500, json: { status: 500, message: 'Internal Server Error' }
  end

  protected

  def authenticate_request!
    unless user_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    begin
      @current_user = User.find(auth_token[0]["user"]["id"])
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
    end
  end

  private

  def http_token
    @http_token ||= request.headers['Authorization'].split.last if request.headers['Authorization'].present?
  end

  def auth_token
    @auth_token ||= decrypt(http_token)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[0]["user"]["id"].to_i
  end

  def payload(user, password)
    return nil unless user && user&.id

    jti_raw = [user.id, Time.now.to_i].join(':')
    jti = Digest::SHA256.hexdigest(jti_raw)

    payload = {
      jti: jti, 
      exp: (Time.now + 2.week).to_i,
      user: {
        id: user.id, 
        email: user.email, 
        nickname: user.nickname
      }
    }

    return JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end

  def decrypt(token)
    JWT.decode(token, Rails.application.credentials.secret_key_base)
  rescue StandardError => e
    puts "#{e.message}"
  end
end
