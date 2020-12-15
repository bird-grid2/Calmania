class ShowsController < ApplicationController
  require 'line/bot'  # gem 'line-bot-api'
  before_action :client, only: [:broadcast]

  protect_from_forgery except: [:broadcast] # CSRF protection

  def index; end

  def broadcast
    messages = {
      type: 'text',
      text: '時間になりました。</br>定期入力の時間です。'
    }
    client.broadcast(messages)
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
end
