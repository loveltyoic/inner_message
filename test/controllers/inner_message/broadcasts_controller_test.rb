require 'test_helper'

module InnerMessage
  class BroadcastsControllerTest < ActionController::TestCase
    setup do
      @channel = create(:channel)
      @broadcast = @channel.send_broadcast('test', 'test')
    end

    test "read_count" do
      assert_equal @broadcast.read_count, 0
      user = create(:user)
      @broadcast.read_by_user user.id
      get :read_count, use_route: :inner_message, ids: [@broadcast.id]
      assert_equal JSON.parse(response.body), {"#{@broadcast.id}" => "1"}
    end
  end
end
