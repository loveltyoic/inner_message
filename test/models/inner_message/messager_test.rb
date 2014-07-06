require 'test_helper'

describe InnerMessage::Messager do 
  let(:sender) { Player.create }
  let(:receiver) { Player.create }
  let(:redis) { Redis.new }

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

  it 'should publish message after send' do
    skip
    thread = Thread.new do 
      redis.subscribe("inner_message.#{receiver.id}") do |on|
        on.message do |channel, message|
          message_content = message
          redis.quit
        end
      end
    end
    sender.send_message({to_id: receiver.id, content: 'I love ruby!'})
    thread.join
    message_content.must_equal 'I love ruby!'
  end

end