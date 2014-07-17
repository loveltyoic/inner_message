require 'test_helper'

module InnerMessage
  class IframesControllerTest < ActionController::TestCase
    setup do 
      @user = InnerMessage.user_class.create
      session[InnerMessage.user_session_key] = @user.id
    end

    test "generate token" do
      get :show, use_route: :inner_message
      assert_equal @user.id, @controller.current_user_id
      assert_equal assigns(:token).secret, @user.reload.message_token.secret
    end
  end
end
