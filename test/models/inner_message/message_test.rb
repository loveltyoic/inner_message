require 'test_helper'
module InnerMessage
  describe Message do 
    let(:sender) { InnerMessage.user_class.create }
    let(:receiver) { InnerMessage.user_class.create }
    let(:another_receiver) { InnerMessage.user_class.create }

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

    it 'have from user' do 
      msg = sender.send_message({to_id: receiver, content: @string})
      msg.from.must_equal sender
    end
  end
end
