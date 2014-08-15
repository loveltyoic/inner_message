module InnerMessage
  module MessagesHelper
    def sign_in_user
      session[:inner_message_current_user] = session[InnerMessage.user_session_key]
      session[:visitor] ||= Visitor.create.id
    end

    def current_user_id
      session[:inner_message_current_user] || 'anonymity'
    end

    def current_visitor
      Visitor.find(session[:visitor])
    end
  end
end
