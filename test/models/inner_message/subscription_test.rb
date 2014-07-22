require 'test_helper'

module InnerMessage
  describe Subscription do
    before do
      @user = InnerMessage.user_class.create
      @channel = MessageChannel.create(name: 'test')
      @user.subscribe_channel(@channel.id)
    end    

    it "user can subscribe channel" do
      @user.message_channels.must_include @channel
    end

    it "receive broadcasts from channel" do 
      broadcast = @channel.broadcasts.create({content: 'this is a test broadcast'})
      @user.get_broadcasts['test'].must_include broadcast
    end

  end
end