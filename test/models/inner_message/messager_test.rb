require 'test_helper'

describe InnerMessage::Messager do 
  let(:sender) { Player.create }
  let(:receiver) { Player.create }

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
    receiver.get_messages.last.from_id.must_equal sender.id
  end

  it 'return false if send to user not exists' do
    sender.send_message({to_id: 10000, content: 'Nobody receive this message'}).must_equal false
  end

end