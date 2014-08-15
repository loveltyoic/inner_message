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
      find_messager('from')
    end

    def to
      find_messager('to')
    end

    after_create :publish_message_to_faye
    def publish_message_to_faye
      FayeClient.send(self.to.session_key, self.serializable_hash)
    end

    private
    def find_messager(type)
      type_id = self.send("#{type}_id")
      if messageable_type == "InnerMessage::MessageBox"
        InnerMessage.user_class.find(type_id)
      else
        messageable_type.constantize.find(type_id)
      end
    end
  end
end
