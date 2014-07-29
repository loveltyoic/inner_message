require 'faye'
Faye::WebSocket.load_adapter('thin')
# change you access token

FAYE_CONFIG = YAML.load_file("../config/inner_message_config.yml")[ENV['RACK_ENV']]['faye']
FAYE_TOKEN = FAYE_CONFIG["token"]

app = Faye::RackAdapter.new(:mount => '/faye', :timeout => 25)
class FayeAuth
  def incoming(message, callback)
    if message['channel'] !~ %r{^/meta/}
      if message["data"]
        if message["data"]['token'] != FAYE_TOKEN
          # Setting any 'error' against the message causes Faye to not accept it.
          message['error'] = "Faye authorize faild."
        else
          message["data"].delete('token')
        end
      end
    end
    callback.call(message)
  end
end
#app.add_extension(FayeAuth.new)

run app
