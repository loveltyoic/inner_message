require 'redis'
module InnerMessage
  class Message < ActiveRecord::Base
    belongs_to :messageable, polymorphic: true

    validate :content, presense: true
    validate :to_id, presense: true

    after_save :publish_message_to_redis
    def publish_message_to_redis
      redis = Redis.new
      redis.publish("inner_message.#{self.to_id}", self.content)
    end
  end
end
