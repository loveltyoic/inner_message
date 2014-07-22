module InnerMessage
  class Broadcast < ActiveRecord::Base
    belongs_to :message_channel

    after_create :publish_to_faye

    scope :recent, ->(count) { order(created_at: :desc).limit(count)}
    private 
    def publish_to_faye
      FayeClient.send('channel-'+self.message_channel_id.to_s, self.serializable_hash)
    end

  end
end