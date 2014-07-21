module InnerMessage
  class Subscription < ActiveRecord::Base
    belongs_to :user, class_name: InnerMessage.user_class.to_s
    belongs_to :message_channel
  end
end