require "inner_message/engine"
require "inner_message/messager"
require "inner_message/view_helper"
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
