class WebhookController < ApplicationController
  require 'line/bot'  # gem 'line-bot-api'
  before_action :validates_signature

  protect_from_forgery except: [:callback, :bot_broadcast] # CSRF protection

  class Clock
    require 'clockwork'
    require 'active_support/time'
    require File.expand_path('../config/boot', __dir__)
    require File.expand_path('../config/environment', __dir__)
  end

  def callback
    body = request.body.read
    events = client.parse_events_from(body)

    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = {
            type: 'text',
            text: event.message['text']
          }
          client.reply_message(event['replyToken'], message)
        end
      end
    end
    "OK"
  end

  def bot_boradcast
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]

    obj = Webhook::Clock.new

    obj.send(@current_user)
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_ACCESS_TOKEN"]
    end
  end

  def validates_signature
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    halt 400, { 'Content-Type' => 'text/plain' }, 'Bad Request' unless client.validate_signature(body, signature)
  end
end
