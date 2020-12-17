require 'line/bot'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :validate_signature, only: [:callback, :broadcast]

  def after_sign_in_path_for(*)
    managements_path
  end

  def after_sign_out_path_for(*)
    root_path
  end

  def client
    @client ||= Line::Bot::Client.new do |config|
      congig.channel_id = ENV["LINE_CHANNEL_ID"]
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_ACCESS_TOKEN"]
    end
  end

  def validate_signature
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 { 'Bad Request' }
    end
  end

  protected

  def configure_permitted_parameters
    add_list = [ :nickname, :email, :height, :ideal_protain_rate, :ideal_fat_rate, :ideal_carbohydrate_rate, :password, :password_confirmation, :period_id, :send_time, :target_cal ]
    devise_parameter_sanitizer.permit :sign_up, keys: add_list
    devise_parameter_sanitizer.permit :account_update, keys: add_list
  end
end
