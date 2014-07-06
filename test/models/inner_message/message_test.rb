require 'test_helper'
module InnerMessage
  describe Message do 
    let(:sender) { Player.create }
    let(:receiver) { Player.create }
    let(:another_receiver) { Player.create }

    before do
      @string = 'I love ruby!'
    end

    it 'should be set to unread when sending' do
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
  end
end
