require 'test_helper'

module InnerMessage
  class MessagesControllerTest < ActionController::TestCase
    setup do
      @receiver = create(:user)
      session[InnerMessage.user_session_key] = @receiver.id      
      @sender = create(:user)
    end

    test "show unread messages" do
      msg = @sender.send_message({to_id: @receiver.id, content: 'I love ruby'})
      get :index, use_route: :inner_message
      assert_includes assigns(:unread), msg
    end

    test "not signed in user" do 
      session[InnerMessage.user_session_key] = nil
      get :index, use_route: :inner_message
      assert_empty assigns(:unread)
    end

    test "read message" do
      msg = @sender.send_message({to_id: @receiver.id, content: 'I love ruby'})
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

    test "reply message to sender" do
      msg = @sender.send_message({to_id: @receiver.id, content: 'I love ruby'})
      post :reply, use_route: :inner_message, id: msg.id, content: 'I love ruby, too'
      assert_includes @sender.get_messages.unread, assigns(:reply_message)
    end

    test "cannot reply message sent to others" do 
      @another = InnerMessage.user_class.create
      msg = @sender.send_message({to_id: @another.id, content: 'I love ruby'})
      post :reply, use_route: :inner_message, id: msg.id, content: 'Cannot reply this'
      assert_response 403
    end

  end
end
