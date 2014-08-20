require_dependency "inner_message/application_controller"
module InnerMessage
  class ChatsController < ApplicationController
    layout 'inner_message/chat'
    def show
      @faye_server = CONFIG['faye']['server']
      @visitor = current_visitor
      @operator_id = Operator.pluck(:id).sample
    end

    def create
      if current_visitor
        @msg = current_visitor.send_message(to_id: params[:operator_id], content: params[:content])
        render json: @msg
      else
        render 403
      end
    end

  end
end