require 'test_helper'
module InnerMessage
  describe Message do
    let(:sender) { create(:user) }
    let(:receiver) { create(:user) }
    let(:another_receiver) { create(:user) }

    before do
      @string = 'I love ruby!'
    end

    it 'should set to unread after create' do
      sender.send_message({to_id: receiver.id, content: @string}).read.must_equal false
    end

    it 'mark message as read' do
      sent = sender.send_message({to_id: receiver.id, content: @string})
      sent.mark_as_read
      sent.read.must_equal true
    end

    it 'get unread messages by scope' do
      mm = sender.send_message({to_id: another_receiver.id, content: @string})
      another_receiver.get_messages.unread.count.must_equal 1
    end

    it 'has to and from' do
      msg = sender.send_message({to_id: receiver.id, content: @string})
      msg.from.must_equal sender.agent
      msg.to.must_equal receiver.agent
    end

    it 'record from type' do 
      msg = sender.send_message(to_id: receiver.id, content: @string)
      msg.from_type.must_equal 'InnerMessage::Agent'
    end
  end
end
