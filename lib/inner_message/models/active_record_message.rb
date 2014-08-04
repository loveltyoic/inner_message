module InnerMessage
  class Message < ActiveRecord::Base
    belongs_to :messageable, polymorphic: true
    belongs_to :from, class_name: InnerMessage.user_class.to_s

    validates :content, presense: true
    validates :to_id, presense: true, numericality: { only_integer: true }
    validates :from_id, presense: true, numericality: { only_integer: true }

    scope :unread, -> { where(read: false) }

    def mark_as_read
      self.update({read: true})
    end

    after_create :publish_message_to_faye
    def publish_message_to_faye
      FayeClient.send(MessageToken.get_secret(self.to_id), self.serializable_hash)
    end
  end
end
