module InnerMessage
  class ApplicationController < ActionController::Base
    include MessagesHelper
    before_action :sign_in_user
  end
end
