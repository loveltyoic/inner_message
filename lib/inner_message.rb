require "inner_message/engine"

module InnerMessage
  mattr_accessor :user_class, :name_field

  class << self
    def configure
      yield self
    end

    def user_class
      @@user_class.constantize
    end
  end

end
