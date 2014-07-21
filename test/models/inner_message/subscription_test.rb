require 'test_helper'

module InnerMessage
  describe Subscription do
    before do
      @user = InnerMessage.user_class.create
      @channel = MessageChannel.create
    end    

    it "user can subscribe channel" do
      @user.subscribe_channel(@channel.id)
      @user.message_channels.must_include @channel
    end

    it "receive message from channel" do 
      @channel.messages.create({})
    end

  end
end