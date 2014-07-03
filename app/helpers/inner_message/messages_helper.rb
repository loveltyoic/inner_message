module InnerMessage
  module MessagesHelper
    def sign_in_user
      session[:inner_message_current_user] = session[:current_user]
    end

    def current_user
      session[:inner_message_current_user] || 'anonymity'
    end

    def get_message
       
    end
  end
end
