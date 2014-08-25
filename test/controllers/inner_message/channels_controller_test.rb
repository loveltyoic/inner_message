require 'test_helper'

module InnerMessage
  class ChannelsControllerTest < ActionController::TestCase
    test "index" do
      get :index, use_route: :inner_message
      assert_equal assigns(:channels).size, Channel.count
    end
  end
end
