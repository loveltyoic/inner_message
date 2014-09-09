require_dependency "inner_message/application_controller"

module InnerMessage
  class AdminsController < ApplicationController
    # before_action :check_admin
    layout 'inner_message/admin'
    def show
    end
  end
end
