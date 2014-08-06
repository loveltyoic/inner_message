module InnerMessage
  class Broadcast < ActiveRecord::Base
    belongs_to :message_channel

    validates :message_channel_id, presence: true
    validates :title, presence: true
    validates :content, presence: true

    after_create :publish_to_faye
    after_create :store_id_in_redis

    scope :recent, ->(count) { order(created_at: :desc).limit(count)}

    def read_by_user(user_id)
      $inner_redis.sadd "inner_message:#{user_id}:read_broadcasts", self.id
      $inner_redis.incr "inner_message:#{self.id}:read_count"
    end

    def read_by_user?(user_id)
      $inner_redis.sismember "inner_message:#{user_id}:read_broadcasts", self.id
    end

    def read_count
      $inner_redis.get("inner_message:#{self.id}:read_count").to_i
    end

    private 
    def publish_to_faye
      FayeClient.send('channel-'+self.message_channel_id.to_s, self.serializable_hash)
    end

    def store_id_in_redis
      $inner_redis.sadd "inner_message:#{self.message_channel_id.to_s}:broadcasts", self.id
    end

  end
end