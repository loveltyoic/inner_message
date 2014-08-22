require 'test_helper'
module InnerMessage
  class OperatorsControllerTest < ActionController::TestCase
    setup do
      @visitor = create(:visitor)
      @operator = create(:operator)
    end
 
    test 'index' do 
      get :index, use_route: :inner_message
      assert_equal assigns(:operators), Operator.all
    end

    test 'create' do 
      post :create, use_route: :inner_message
      assert_response 200
    end

    test 'reply' do
      post :reply, use_route: :inner_message, id: @operator.id, visitor_id: @visitor.id, content: 'ok'
      assert_includes @visitor.get_messages, assigns(:msg)
    end
  end
end