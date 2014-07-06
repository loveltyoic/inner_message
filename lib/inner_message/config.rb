module InnerMessage
  mattr_accessor :user_class, :user_session_key

  class << self
    def configure
      yield self
    end

    def user_class
      @@user_class.constantize
    end
  end

end