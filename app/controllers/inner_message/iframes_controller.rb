require_dependency "inner_message/application_controller"

module InnerMessage
  class IframesController < ApplicationController
    def show
      @token = current_talker.session_key
      @faye_server = CONFIG['faye']['server']
    end
  end
end
