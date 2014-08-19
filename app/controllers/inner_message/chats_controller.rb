require_dependency "inner_message/application_controller"
module InnerMessage
  class ChatsController < ApplicationController
    layout 'inner_message/chat'
    def show
      @faye_server = CONFIG['faye']['server']
      @visitor = current_visitor
    end
  end
end