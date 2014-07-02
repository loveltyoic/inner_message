require 'redis'
module InnerMessage
  class Message < ActiveRecord::Base
    after_save :publish_message_to_redis
    def publish_message_to_redis
      redis = Redis.new
      redis.publish('default', self.text)
    end
  end
end
