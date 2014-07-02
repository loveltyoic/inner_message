require 'redis'
module InnerMessage
  class Message < ActiveRecord::Base
    belongs_to :from, class_name: InnerMessage.user_class.to_s
    belongs_to :message_box

    after_save :publish_message_to_redis
    def publish_message_to_redis
      redis = Redis.new
      redis.publish('default', self.content)
    end
  end
end
