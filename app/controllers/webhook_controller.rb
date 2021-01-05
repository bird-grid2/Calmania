class WebhookController < ApplicationController
  require 'line/bot'
  protect_from_forgery except: [:callback, :broadcast] # CSRF protection

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    response_bad_request unless client.validate_signature(body, signature)

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
    head :ok
  end

  def broadcast
    messages = {
      type: 'text',
      text: '時間になりました。\n定期入力の時間です。'
    }
    client.broadcast(messages)
  end

  def reply_content(event, messages)
    res = client.reply_message(
      event['replyToken'],
      messages
    )
    logger.warn res.read_body unless Net::HTTPOK === res
    res
  end

  def handle_sticker(event)
    # Message API available stickers
    # https://developers.line.me/media/messaging-api/sticker_list.pdf
    msgapi_available = event.message['packageId'].to_i <= 4
    messages = [{
      type: 'text',
      text: "[STICKER]\npackageId: #{event.message['packageId']}\nstickerId: #{event.message['stickerId']}"
    }]
    if msgapi_available
      messages.push(
        type: 'sticker',
        packageId: event.message['packageId'],
        stickerId: event.message['stickerId']
      )
    end
    reply_content(event, messages)
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_id = ENV["LINE_CHANNEL_ID"]
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_ACCESS_TOKEN"]
      config.http_options = {
        open_timeout: 5,
        read_timeout: 5
      }
    end
  end
end
