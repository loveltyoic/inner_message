require_dependency "inner_message/application_controller"

module InnerMessage
  class MessagesController < ApplicationController
    include ActionController::Live
    
    def index
      response.headers['Content-Type'] = 'text/event-stream'
      redis = Redis.new
      redis.subscribe('default') do |on|
        on.message do |channel, message|
          response.stream.write message
        end
      end
    rescue IOError
    ensure
      redis.quit
      response.stream.close
    end

    def create
      Message.create(message_params)
      render json: { status: 'success' }
    end

  private
    def message_params
      params.require(:message).permit(:text)
    end
  end
end
