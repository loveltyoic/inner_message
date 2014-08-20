require 'test_helper'
module InnerMessage
  class ChatsControllerTest < ActionController::TestCase
    setup do
      @operator = create(:operator)
    end

    test 'chat between visitor and operator' do
      post :create, use_route: :inner_message, content: 'I need help!', operator_id: @operator.id
      assert_includes @operator.get_messages, assigns(:msg)
    end
  end
end