require_dependency "inner_message/application_controller"

module InnerMessage
  class MessagesController < ApplicationController
    include ActionController::Live
    
    def index
      response.headers['Content-Type'] = 'text/event-stream'
      redis = Redis.new
      sse = SSE.new(response.stream, retry: 300, event: "message")
      redis.subscribe(params[:user]) do |on|
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

    def create
      if MessageBox.send_message(message_params)
        render json: { status: 'success' }
      else
        render json: { status: 'error', message: "#{params[:message][:to]} does not exist!"}
      end      
    end

  private
    def message_params
      params.require(:message).permit(:content, :to)
    end
  end
end
