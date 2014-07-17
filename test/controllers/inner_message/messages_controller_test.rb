require 'test_helper'

module InnerMessage
  class MessagesControllerTest < ActionController::TestCase
    setup do
      @user = InnerMessage.user_class.create
      session[InnerMessage.user_session_key] = @user.id      
      @sender = InnerMessage.user_class.create
    end

    test "show unread messages" do
      msg = @sender.send_message({to_id: @user.id, content: 'I love ruby'})
      get :index, use_route: :inner_message
      assert_includes assigns(:unread), msg
    end

    test "read message" do
      msg = @sender.send_message({to_id: @user.id, content: 'I love ruby'})
      get :read, use_route: :inner_message, id: msg.id
      assert_equal msg.reload.read, true
      assert_response :success
    end

    test "cannot read other's message" do
      @another = InnerMessage.user_class.create
      msg = @sender.send_message({to_id: @another.id, content: 'I love ruby'})
      get :read, use_route: :inner_message, id: msg.id
      assert_equal response.status, 403
    end
  end
end
