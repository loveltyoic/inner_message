module InnerMessage
  module Messager
    extend ActiveSupport::Concern

    included do
      has_one :agent, class_name: 'InnerMessage::Agent', foreign_key: :user_id
      has_many :channels, class_name: 'InnerMessage::Channel', through: :subscriptions
      has_many :subscriptions, class_name: 'InnerMessage::Subscription', foreign_key: :user_id
    end

    def get_messages
      check_agent { |ag| ag.get_messages }
    end

    def send_message(params)
      check_agent do |ag|
        to_user = self.class.find(params[:to_id])
        to_agent = to_user.agent || to_user.create_agent
        to_agent.messages.create(to_id: to_agent.id, content: params[:content], from_id: ag.id)
      end
    rescue ActiveRecord::RecordNotFound
      false
    end

    def subscribe_channel(channel_id)
      InnerMessage::Subscription.create({user_id: self.id, channel_id: channel_id})
    end

    def unsubscribe_channel(channel_id)
      InnerMessage::Subscription.destroy_all({user_id: self.id, channel_id: channel_id})
    end

    def get_broadcasts_by_channel_id(channel_id)
      check_subscription(channel_id) do
        channel = InnerMessage::Channel.find(channel_id)
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
      subscription = InnerMessage::Subscription.where({user_id: self.id, channel_id: channel_id}).first
      if subscription
        yield
      else
        nil
      end
    end

    def check_agent
      @agent = self.agent || self.create_agent
      yield @agent
    end

  end
end