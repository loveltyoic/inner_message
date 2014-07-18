
module InnerMessage
  class MessagesController < ApplicationController

    def index
      @unread = InnerMessage.user_class.find(current_user_id).get_messages.unread      
    rescue
      @unread = []
    ensure
      render json: @unread
    end

    def read
      message = Message.find(params[:id])
      if message.to_id == current_user_id 
        message.mark_as_read
        render json: {status: 'success'}
      else 
        render json: {message: 'Forbidden'}, status: 403
      end
    end

    def reply
      message = Message.find(params[:id])
      if message.to_id == current_user_id
        @reply_message = InnerMessage.user_class.find(current_user_id).send_message({to_id: message.from_id, content: params[:content]})
        render json: {status: 'success'}
      else
        render json: {message: 'Forbidden'}, status: 403
      end
    end

  end
end
