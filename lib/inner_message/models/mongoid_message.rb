module InnerMessage
  class Message
    include Mongoid::Document
    belongs_to :messageable, polymorphic: true

    field :content, type: String
    field :to_id, type: Moped::BSON::ObjectId
    field :from_id, type: Moped::BSON::ObjectId
    
    validate :content, presense: true
    validate :to_id, presense: true
    validate :from_id, presense: true

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
