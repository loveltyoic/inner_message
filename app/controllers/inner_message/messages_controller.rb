
module InnerMessage
  class MessagesController < ApplicationController
    include MessagesHelper
    before_action :sign_in_user

    def index
      unread = InnerMessage.user_class.find(session[:inner_message_current_user]).get_messages.unread      
      render json: unread
    end

    def read
      message = Message.find(params[:id])
      if message.to_id == current_user 
        message.mark_as_read
        render json: {status: 'success'}
      else 
        render json: {message: 'Forbidden'}, status: 403
      end

    end

  end
end
