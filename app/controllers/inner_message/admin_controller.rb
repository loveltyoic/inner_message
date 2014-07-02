require_dependency "inner_message/application_controller"

module InnerMessage
  class AdminController < ApplicationController
    def index
      @users = InnerMessage.user_class.all
    end
  end
end
