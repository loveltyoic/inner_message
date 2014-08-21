module InnerMessage
  module MessagesHelper
    def sign_in_user
      session[:inner_message_current_user] = session[InnerMessage.user_session_key]
      signed_user.create_agent if (signed_user && signed_user.agent.nil?)
      session[:visitor] ||= Visitor.create.id
    end

    def current_talker
      signed_user ? signed_user.agent : Visitor.find(session[:visitor])
    end

    def signed_user
      InnerMessage.user_class.find(session[:inner_message_current_user])
    rescue
      nil
    end

  end
end
