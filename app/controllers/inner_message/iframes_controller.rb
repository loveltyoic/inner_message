require_dependency "inner_message/application_controller"

module InnerMessage
  class IframesController < ApplicationController
    include MessagesHelper
    before_action :sign_in_user
    
    def show
    end
  end
end
