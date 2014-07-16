module InnerMessage
  module Messager
    extend ActiveSupport::Concern

    included do 
      has_one :message_box, class_name: 'InnerMessage::MessageBox', foreign_key: :user_id
      has_one :message_token, class_name: 'InnerMessage::MessageToken', foreign_key: :user_id
    end

    def get_messages
      self.message_box.nil? ? self.create_message_box.messages : self.message_box.messages
    end

    def send_message(params)
      to = self.class.find(params[:to_id])
      mb = to.message_box || to.create_message_box
      mb.messages.create params.merge!({from_id: self.id})
    rescue Mongoid::Errors::DocumentNotFound
      false            
    end

  end
end