require 'test_helper'
module InnerMessage
  describe Messager do
    let(:sender) { create(:user) }
    let(:receiver) { create(:user) }
    let(:channel) { create(:channel) }
    let(:subscriber) { create(:user) }

    before do
      sender.send_message({to_id: receiver.id, content: 'I love ruby!'})
    end

    it 'can send message' do
      sender.must_respond_to :send_message
    end

    it 'can receive messages' do
      receiver.must_respond_to :get_messages
    end

    it 'should send message to receiver' do
      receiver.get_messages.last.content.must_equal 'I love ruby!'
    end

    it 'should receive message from sender' do
      receiver.get_messages.last.from_id.must_equal sender.agent.id
    end

    it 'return false if send to user not exists' do
      sender.send_message({to_id: 10000, content: 'Nobody receive this message'}).must_equal false
    end

    it 'get all broadcasts from channel' do
      3.times { |i| channel.send_broadcast("test", "broadcast No.#{i}") }
      subscriber.subscribe_channel(channel.id)
      subscriber.get_broadcasts_by_channel_id(channel.id).count.must_equal 3
    end

    it 'get unread broadcasts' do
      subscriber.subscribe_channel(channel.id)
      unread_1 = channel.send_broadcast("title 1", 'broadcast_1')
      unread_2 = channel.send_broadcast("title 2", 'broadcast_2')

      subscriber.get_unread_broadcasts_by_channel_id(channel.id).count.must_equal 2
      unread_1.read_by_user(subscriber.id)
      subscriber.get_unread_broadcasts_by_channel_id(channel.id).count.must_equal 1
    end

    it 'get nothing from unsubscribed channel' do
      channel.send_broadcast('Not Seen', "User could not read this if he/she doesn't subscribe.")
      subscriber.get_broadcasts_by_channel_id(channel.id).must_be_nil
    end

    it "get subscribed channels' ids" do
      subscriber.subscribe_channel(channel.id)
      subscriber.subscribed_channels.must_include channel.id
      sc = create(:system_channel)
      subscriber.subscribed_channels.must_include sc.id
    end

  end
end