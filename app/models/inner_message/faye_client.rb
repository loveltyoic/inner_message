require 'net/http'
module InnerMessage
  FAYE_CONFIG = YAML.load_file("#{Rails.root}/config/faye_config.yml")[ENV['RACK_ENV']]
  class FayeClient
    def self.send(channel, params)
        params[:token] = FAYE_CONFIG["faye_token"]
        message = { channel: channel, data: params }
        uri = URI.parse(FAYE_CONFIG["faye_server"])
        Net::HTTP.post_form(uri, message: message.to_json)
        binding.pry
    end
  end
end