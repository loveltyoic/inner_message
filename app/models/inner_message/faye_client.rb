require 'net/http'

module InnerMessage
  class FayeClient
    def self.send(channel, params)
      Thread.new {
        params[:token] = CONFIG["faye"]["token"]
        message = {channel: '/'+channel, data: params}
        uri = URI.parse(CONFIG["faye"]["server"])
        Net::HTTP.post_form(uri, message: message.to_json)
      }
    end
  end
end