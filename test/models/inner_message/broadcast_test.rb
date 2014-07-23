require 'test_helper'

module InnerMessage
  describe Broadcast do
    before do
      @channel = InnerMessage::MessageChannel.create(name: 'test')
      @message = @channel.broadcasts.create(content: 'Test!')
      @user = InnerMessage.user_class.create
      @user.subscribe_channel(@channel.id)
    end

    it "read by user" do
      @message.read_by_user(@user.id)
      @message.read_by_user?(@user.id).must_equal true
      @message.read_count.must_equal 1
    end

  end
end