require 'test_helper'

describe InnerMessage::Messager do 
  let(:sender) { Player.create }
  let(:receiver) { Player.create }

  before do
    sender.send_message({to_id: receiver.id, content: 'I love ruby!'})
  end

  it 'can send message' do
    sender.respond_to?(:send_message).must_equal true
  end

  it 'can receive messages' do
    receiver.respond_to?(:get_messages).must_equal true
  end

  it 'should send message to receiver' do
    receiver.get_messages.last.content.must_equal 'I love ruby!'
  end

  it 'should receive message from sender' do
    receiver.get_messages.last.from_id.must_equal sender.id
  end
end