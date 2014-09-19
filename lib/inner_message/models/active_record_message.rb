module InnerMessage
  class Message < ActiveRecord::Base
    belongs_to :messageable, polymorphic: true

    validates :content, presence: true
    validates :to_id, presence: true, numericality: { only_integer: true }
    validates :from_id, presence: true, numericality: { only_integer: true }

    scope :unread, -> { where(read: false) }

    def mark_as_read
      self.update({read: true})
    end

    def from
      InnerMessage::Talker.find(from_id)
    end

    def to
      InnerMessage::Talker.find(to_id)
    end

    after_create :publish_message_to_faye
    def publish_message_to_faye
      FayeClient.send(self.from_type.gsub('::', '/') + '/' + self.to.session_key, self.serializable_hash)
    end
  end
end
