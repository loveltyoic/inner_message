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

    it "user can unsubscribe channel" do 
      @user.unsubscribe_channel(@channel.id)
      @user.message_channels.wont_include @channel
    end

    it "receive broadcasts from channel" do 
      broadcast = @channel.broadcasts.create({content: 'this is a test broadcast'})
      @user.get_broadcasts_by_channel_id(@channel.id).must_include broadcast
    end

    it "get unread broadcasts from channel" do
      broadcast = @channel.broadcasts.create({content: 'Test!'})
      @user.get_unread_broadcasts_by_channel_id(@channel.id).must_include broadcast
      broadcast.read_by_user(@user.id)
      @user.get_unread_broadcasts_by_channel_id(@channel.id).wont_include broadcast
    end

  end
end