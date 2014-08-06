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

  end
end