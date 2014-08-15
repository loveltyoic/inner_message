require 'securerandom'

module InnerMessage
  class Talker < ActiveRecord::Base
    has_many :messages, as: :messageable

    # message must include to_id, content
    def send_message(message)
      Talker.find(message[:to_id]).messages.create(to_id: message[:to_id], from_id: self.id, content: message[:content])
    end

    def get_messages
      self.messages
    end

    before_create :generate_session_key
    def generate_session_key
      self.session_key = SecureRandom.hex(10)
    end
  end
end