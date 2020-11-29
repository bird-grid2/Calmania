class WebhookController < ApplicationController
  require 'line/bot'  # gem 'line-bot-api'
  before_action :validates_signature
  before_action :login, only: [:callback, :broadcast_message]

  protect_from_forgery except: [:callback, :send] # CSRF protection

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
      when Line::Bot::Event::Follow 
        userid = event['source']['userId'] 
        follower = Follower.new
        follower.line_id = userid
        follower.save
        message = { type: 'text', text: '友達登録ありがとうございます' }
        client.push_message(follower.line_id, message)
      when Line::Bot::Event::Unfollow 
        userid = event['source']['userId']
        follower = Follower.find_by(line_id: userid)
        follower.destroy
      end
    end
    "OK"
  end

  def broadcast_message
    
    message = {
      type: 'text',
      text: '時間になりました。</br>定期入力の時間です。'
    }
    userId = Follower.find_by(user_id: @current_user)
    client.push_message(userId, message)
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      congig.channel_id = ENV["LINE_CHANNEL_ID"]
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_ACCESS_TOKEN"]
    end
  end

  def validates_signature
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    halt 400, { 'Content-Type' => 'text/plain' }, 'Bad Request' unless client.validate_signature(body, signature)
  end

  def login
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
