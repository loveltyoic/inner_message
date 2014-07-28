require_dependency "inner_message/application_controller"

module InnerMessage
  class IframesController < ApplicationController
    def show
      @token = MessageToken.generate(current_user_id)
      @faye_server = InnerMessage::CONFIG['faye']['server']
    end
  end
end
