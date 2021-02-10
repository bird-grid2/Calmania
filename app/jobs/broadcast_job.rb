class BroadcastJob < ApplicationJob
  queue_as :broadcast

  def perform(job_name)
    require 'net/https'
    require 'uri'

    puts "clockwork run #{job_name}"
    uri = URI.parse("https://calmania.work/send")
    http = Net::HTTP.new(uri.host, uri.port)

    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    message = 'test'

    http.start do
      req = Net::HTTP::Post.new(uri.path)
      req.set_form_data({ body: message })
      http.request(req)
    end
  end
end
