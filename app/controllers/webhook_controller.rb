require 'line/bot'  # gem 'line-bot-api'

class WebhookController < ApplicationController
  protect_from_forgery except: [:callback, :broadcast] # CSRF protection

  def client
    @client ||= Line::Bot::Client.new do |config|
      congig.channel_id = ENV["LINE_CHANNEL_ID"]
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_ACCESS_TOKEN"]
    end
  end

  def callback
    body = request.body.read
    
    begin
      signature = request.env['HTTP_X_LINE_SIGNATURE']
    rescue
      return if client.validate_signature(body, signature)
      puts "400 Bad Request"
    end

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
        when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
          response = client.get_message_content(event.message['id'])
          tf = Tempfile.open("content")
          tf.write(response.body)
        end
      end
    end
    "OK"
  end

  def broadcast
    messages = {
      type: 'text',
      text: '時間になりました。</br>定期入力の時間です。'
    }
    client.broadcast(messages)
  end
end
