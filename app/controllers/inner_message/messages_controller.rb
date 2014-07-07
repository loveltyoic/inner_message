
module InnerMessage
  class MessagesController < ApplicationController
    include ActionController::Live
    include MessagesHelper
    before_action :sign_in_user

    def index
      response.headers['Content-Type'] = 'text/event-stream'
      redis = Redis.new
      redis.subscribe(["inner_message.#{current_user}", "heartbeat"]) do |on|
        on.message do |channel, message|
          if channel == 'heartbeat'
            response.stream.write("event: heartbeat\ndata: heartbeat\n\n")
          else
            response.stream.write("event: message\ndata: #{message}\n\n")
          end
        end
      end
      render nothing: true      
    rescue IOError
      logger.info "Stream closed"
    ensure
      redis.quit
      response.stream.close
    end
    
  end
end
