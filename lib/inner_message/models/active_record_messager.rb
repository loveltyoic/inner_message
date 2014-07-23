module InnerMessage
  module Messager
    extend ActiveSupport::Concern

    included do 
      has_one :message_box, class_name: 'InnerMessage::MessageBox', foreign_key: :user_id
      has_one :message_token, class_name: 'InnerMessage::MessageToken', foreign_key: :user_id
      has_many :message_channels, class_name: 'InnerMessage::MessageChannel', through: :subscriptions
      has_many :subscriptions, class_name: 'InnerMessage::Subscription', foreign_key: :user_id
    end

    def get_messages
      self.message_box.nil? ? self.create_message_box.messages : self.message_box.messages
    end

    def send_message(params)
      to = self.class.find(params[:to_id])
      mb = to.message_box || to.create_message_box
      mb.messages.create params.merge!({from_id: self.id})
    rescue ActiveRecord::RecordNotFound
      false            
    end

    def subscribe_channel(channel_id)
      InnerMessage::Subscription.create({user_id: self.id, message_channel_id: channel_id})
    end

    def unsubscribe_channel(channel_id)
      InnerMessage::Subscription.destroy_all({user_id: self.id, message_channel_id: channel_id})
    end

    def get_broadcasts_by_channel_id(channel_id)
      check_subscription(channel_id) do
        channel = InnerMessage::MessageChannel.find(channel_id)
        channel.broadcasts
      end
    end

    def get_unread_broadcasts_by_channel_id(channel_id)
      check_subscription(channel_id) do
        unread_ids = $inner_redis.sdiff "inner_message:#{channel_id}:broadcasts", "inner_message:#{self.id}:read_broadcasts"
        InnerMessage::Broadcast.find(unread_ids)
      end
    end

    private 
    def check_subscription(channel_id)
      subscription = InnerMessage::Subscription.where({user_id: self.id, message_channel_id: channel_id}).first
      if subscription
        yield
      else
        nil
      end      
    end


  end
end