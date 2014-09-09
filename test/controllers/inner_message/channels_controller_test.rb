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
    end

  end
end
