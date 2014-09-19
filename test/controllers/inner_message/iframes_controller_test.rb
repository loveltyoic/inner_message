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
      system_channel = create(:system_channel)
      bc = channel.send_broadcast('test', 'test')
      s_bc = system_channel.send_broadcast('system test', 'system test')
      get :channels, use_route: :inner_message
      assert_includes assigns(:channels), { id: channel.id, name: channel.name, broadcasts: [bc] }
      assert_includes assigns(:channels), { id: system_channel.id, name: system_channel.name, broadcasts: [s_bc] }
    end
  end
end
