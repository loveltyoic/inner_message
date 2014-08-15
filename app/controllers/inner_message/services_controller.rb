module InnerMessage
  class Services < ApplicationController
    layout 'service'
    def show
      @visitor = current_visitor
    end
  end
end