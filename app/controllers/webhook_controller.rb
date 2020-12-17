require 'line/bot'  # gem 'line-bot-api'

class WebhookController < ApplicationController
  protect_from_forgery except: [:callback, :broadcast] # CSRF protection

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
