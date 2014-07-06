module InnerMessage
  mattr_accessor :user_class, :user_session_key

  class << self
    def configure
      yield self
      # include InnerMessage::Messager in configured model
      # maybe there's someway to hook this other than excute here.
      user_class.class_eval do
        include InnerMessage::Messager
      end
    end

    def user_class
      @@user_class.constantize
    end
  end

end