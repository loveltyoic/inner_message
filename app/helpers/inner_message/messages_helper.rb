module InnerMessage
  module MessagesHelper
    def sign_in_user
      session[:inner_message_current_user] = session[InnerMessage.user_session_key]
    end

    def current_user_id
      session[:inner_message_current_user] || 'anonymity'
    end

    def get_message
       
    end
  end
end
