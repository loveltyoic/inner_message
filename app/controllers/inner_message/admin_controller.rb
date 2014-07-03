require_dependency "inner_message/application_controller"

module InnerMessage
  class AdminController < ApplicationController
    before_action :check_admin
    def index
      @users = InnerMessage.user_class.all
    end
  end
end
