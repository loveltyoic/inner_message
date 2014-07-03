require_dependency "inner_message/application_controller"

module InnerMessage
  class MessagesController < ApplicationController
    include ActionController::Live
    include MessagesHelper
    before_action :sign_in_user

    def index
      response.headers['Content-Type'] = 'text/event-stream'
      redis = Redis.new
      sse = SSE.new(response.stream, retry: 300, event: "message")
      redis.subscribe("inner_message.#{current_user}") do |on|
        on.message do |channel, message|
          sse.write message
        end
      end
      render nothing: true      
    rescue IOError
      logger.info "Stream closed"
    ensure
      redis.quit
      sse.close
    end

  end
end
