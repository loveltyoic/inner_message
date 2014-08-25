require 'test_helper'

module InnerMessage
  class IframesControllerTest < ActionController::TestCase
    setup do 
      @user = create(:user)
      session[InnerMessage.user_session_key] = @user.id
    end

    test "show" do
      get :show, use_route: :inner_message
      assert_equal @user.agent, @controller.current_talker
      assert_equal assigns(:token), @user.agent.session_key
    end

    test "channels" do 
      channel = create(:channel)
      @user.subscribe_channel channel.id
      bc = channel.send_broadcast('test', 'test')
      get :channels, use_route: :inner_message
      assert_equal assigns(:channels), { id: channel.id, name: channel.name, broadcasts: [bc] }
    end
  end
end
