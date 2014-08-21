require 'test_helper'

module InnerMessage
  describe Broadcast do
    before do
      @channel = create(:channel)
      @message = @channel.send_broadcast('Test', 'This is a test broadcast!')
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