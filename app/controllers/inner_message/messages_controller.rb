
module InnerMessage
  class MessagesController < ApplicationController

    def index
      @unread = current_talker.get_messages.unread
    rescue
      @unread = []
    ensure
      render json: @unread
    end

    def read
      message = Message.find(params[:id])
      if message.to_id == current_talker.id
        message.mark_as_read
        render json: {status: 'success'}
      else
        render json: {message: 'Forbidden'}, status: 403
      end
    end

    def reply
      message = Message.find(params[:id])
      if message.to_id == current_talker.id
        @reply_message = current_talker.send_message({to_id: message.from_id, content: params[:content]})
        render json: {status: 'success', data: @reply_message}
      else
        render json: {message: 'Forbidden'}, status: 403
      end
    end

  end
end
