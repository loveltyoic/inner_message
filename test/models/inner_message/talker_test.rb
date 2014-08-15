require 'test_helper'
module InnerMessage
  describe Talker do
    let (:operator) { create(:operator) }
    let (:visitor) { create(:visitor) }

    it 'can send message to operator' do
      msg = visitor.send_message(to_id: operator.id, content: 'Help!')
      operator.get_messages.must_include msg
    end
  end
end
