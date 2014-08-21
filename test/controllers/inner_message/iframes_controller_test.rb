require 'test_helper'

module InnerMessage
  class IframesControllerTest < ActionController::TestCase
    setup do 
      @user = InnerMessage.user_class.create
      session[InnerMessage.user_session_key] = @user.id
    end

    test "generate session key" do
      get :show, use_route: :inner_message
      assert_equal @user.agent, @controller.current_talker
      assert_equal assigns(:token), @user.agent.session_key
    end
  end
end
