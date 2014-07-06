require 'redis'
module InnerMessage
  class Message < ActiveRecord::Base
    belongs_to :messageable, polymorphic: true

    validate :content, presense: true
    validate :to_id, presense: true
    validate :from_id, presense: true

    scope :unread, -> { where(read: false) }

    def mark_as_read
      self.update({read: true})
    end

    after_create :publish_message_to_redis
    def publish_message_to_redis
      redis = Redis.new
      redis.publish("inner_message.#{self.to_id}", self.to_json)
    end
  end
end
