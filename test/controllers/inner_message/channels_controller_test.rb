require 'test_helper'

module InnerMessage
  class ChannelsControllerTest < ActionController::TestCase
    setup do
      @channel = create(:channel)
      @broadcast = @channel.send_broadcast('test', 'test')
    end

    test "index" do
      get :index, use_route: :inner_message
      assert_equal assigns(:channels).size, Channel.count
    end

    test "broadcasts" do
      get :broadcasts, use_route: :inner_message, id: @channel.id
      assert_equal assigns(:broadcasts), [@broadcast]
      assert_equal assigns(:broadcasts_with_readcount), [@broadcast.serializable_hash.merge({read: 0})]
    end

    test "create system channel" do
      post :create, use_route: :inner_message, name: 'notification', system: true
      assert_equal assigns(:channel).type, 'InnerMessage::SystemChannel'
    end
  end
end
