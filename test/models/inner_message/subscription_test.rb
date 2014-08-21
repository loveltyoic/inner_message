require 'test_helper'

module InnerMessage
  describe Subscription do
    before do
      @user = InnerMessage.user_class.create
      @channel = create(:channel)
      @user.subscribe_channel(@channel.id)
    end    

    it "user can subscribe channel" do
      @user.channels.must_include @channel
    end

    it "user can unsubscribe channel" do 
      @user.unsubscribe_channel(@channel.id)
      @user.channels.wont_include @channel
    end

  end
end