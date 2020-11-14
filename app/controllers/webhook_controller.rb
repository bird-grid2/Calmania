class WebhookController < ApplicationController
  require 'line/bot'  # gem 'line-bot-api'
  before_action :validates_signature

  protect_from_forgery except: [:callback] # CSRF protection


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

  private

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_ACCESS_TOKEN"]
    }
  end

  def validates_signature
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      halt 400, { 'Content-Type' => 'text/plain' }, 'Bad Request'
    end

  end

end
