module InnerMessage
  class MessageChannel < ActiveRecord::Base
    has_many :users, class_name: InnerMessage.user_class.to_s, through: :subscriptions
    has_many :subscriptions
    has_many :messages, as: :messageble
  end
end