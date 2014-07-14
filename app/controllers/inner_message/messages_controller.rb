
module InnerMessage
  class MessagesController < ApplicationController
    include ActionController::Live
    include MessagesHelper
    before_action :sign_in_user

    def index
      
    end
    
  end
end
