
module InnerMessage
  class MessagesController < ApplicationController
    include MessagesHelper
    before_action :sign_in_user

    def index
      unread = InnerMessage.user_class.find(session[:inner_message_current_user]).get_messages.unread      
      render json: unread
    end

  end
end
