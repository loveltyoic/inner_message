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

    after_create :publish_message_to_faye
    def publish_message_to_faye
      FayeClient.send(MessageToken.get_secret(self.to_id), {content: self.content, from_id: from_id, created_at: created_at})
    end
  end
end
